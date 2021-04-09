# dockerhub conf
variable "registry_server" {
    default = "https://index.docker.io/v1/"
}

variable "registry_username" {}
variable "registry_password" {}

variable "ns" {
    default = "neuvector"
}

variable "env_name" {
    default = "nvlabs"
}

variable "scanner_replicas" {
    default = "2"
}

variable "controller_replicas" {
    default = "1"
}

variable "containerd" {
    default = "false"
}

variable "containerd_path" {
    default = "/var/run/containerd/containerd.sock"
}

variable "webui_service" {}

variable "tag" {}

variable "secret_name" {
    default = "docker-cfg"
}
variable "helm_repo" {
    default = "https://neuvector.github.io/neuvector-helm/"
    #default = "https://raw.githubusercontent.com/achdevops/nv-helm/main"
}

variable "helm_chart" {
    default = "core"
    #default = "nv-chart"
}
variable "helm_name" {
    default = "my-release"
}
