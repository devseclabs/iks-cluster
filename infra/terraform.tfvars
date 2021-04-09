# cluster deployment vars

resource_group = "Default"
service_instance_name = "my-svc"
cluster_name = "labs-iks"

# k8s cluster resoruce conf
flavor = "bx2.2x8"
worker_count = "3"
#ibmcloud ks versions
kube_version = "1.19.9"

# ibmcloud ks locations | grep us
zone = "us-south-1"