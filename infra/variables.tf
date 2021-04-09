variable "flavor" {
  default = "bx2.2x8"

}

#variable "ibm_key" {}

variable "worker_count" {
  default = "1"
}

variable "zone" {
  default = "us-south-1"
}

variable "rg" {
  default = "Default"
}

variable "name" {
  default = "cluster"
}

variable "region" {
  default = "us-south"
}

variable "service_instance_name" {
  default = "my-service-instance"
}

variable "cluster_name" {
  default = "iks"
}

variable "kube_version" {
  default = "1.18.15"
}