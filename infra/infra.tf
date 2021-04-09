# cluster example from: https://github.com/IBM-Cloud/terraform-provider-ibm
provider "ibm" {
  generation = 2
}

resource "ibm_resource_group" "resource_group" {
  name = var.rg
}

resource "ibm_is_vpc" "vpc" {
  name = "vpc-nv"

  depends_on = [
    ibm_resource_group.resource_group
  ]
}

resource "ibm_is_vpc_routing_table" "rt" {
  name   = "nv-route-table"
  vpc    = ibm_is_vpc.vpc.id
}


resource "ibm_is_public_gateway" "gw" {
    name = "nv-gw"
    vpc = ibm_is_vpc.vpc.id
    zone = var.zone

    //User can configure timeouts
    timeouts {
        create = "90m"
    }
}

resource "ibm_is_subnet" "subnet" {
  name                     = "subnet-nv"
  vpc                      = ibm_is_vpc.vpc.id
  routing_table            = ibm_is_vpc_routing_table.rt.routing_table
  public_gateway           = ibm_is_public_gateway.gw.id
  zone                     = var.zone
  total_ipv4_address_count = 256
}

# https://cloud.ibm.com/docs/containers?topic=containers-vpc-network-policy#security_groups
resource "ibm_is_security_group" "sg" {
    name = "sg-nv"
    vpc = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group_rule" "sg_rule_udp" {
    group = ibm_is_security_group.sg.id
    direction = "inbound"
    #remote = "127.0.0.1"
    udp {
        port_min = 30000
        port_max = 32767
    }
 }

 resource "ibm_is_security_group_rule" "sg_rule_tcp" {
    group = ibm_is_security_group.sg.id
    direction = "inbound"
    #remote = "127.0.0.1"
    tcp {
        port_min = 30000
        port_max = 32767
    }
 }

resource "ibm_is_security_group_rule" "sg_rule_main" {
    group = ibm_is_security_group.sg.id
    direction = "inbound"
    remote = ibm_is_security_group.sg.id
    
 }

resource "ibm_is_security_group_rule" "sg_outrule_01" {
    group = ibm_is_security_group.sg.id
    direction = "outbound"
    remote = "166.8.0.0/14"
    
 }

 resource "ibm_is_security_group_rule" "sg_outrule_02" {
    group = ibm_is_security_group.sg.id
    direction = "outbound"
    remote = "161.26.0.0/16"
    
 }

 resource "ibm_is_security_group_rule" "sg_outrule_03" {
    group = ibm_is_security_group.sg.id
    direction = "outbound"
    remote = "0.0.0.0/0"
    
 }

resource "ibm_container_vpc_cluster" "cluster" {
  name              = "${var.cluster_name}-nv"
  vpc_id            = ibm_is_vpc.vpc.id
  kube_version      = var.kube_version
  flavor            = var.flavor
  worker_count      = var.worker_count
  resource_group_id = ibm_resource_group.resource_group.id

  zones {
    subnet_id = ibm_is_subnet.subnet.id
    name      = var.zone
  }

  
}

resource "ibm_resource_instance" "cos_instance" {
  name     = var.service_instance_name
  service  = "cloud-object-storage"
  plan     = "standard"
  location = "global"

  depends_on = [
    ibm_resource_group.resource_group
  ]
}

resource "ibm_container_bind_service" "bind_service" {
  cluster_name_id     = ibm_container_vpc_cluster.cluster.id
  service_instance_id = element(split(":", ibm_resource_instance.cos_instance.id), 7)
  namespace_id        = "default"
  role                = "Writer"
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = ibm_container_vpc_cluster.cluster.id
}