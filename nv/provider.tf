provider "helm" {
  kubernetes {
    # output path from infra deployment
    config_path = "/home/devops/c01341b8c0a2a7ad6dfdc6a134da49d06b744a82_c04o31vd02aiolimerig_k8sconfig/config.yml"
    #config_context = "iks-nvlabs/c04o31vd02aiolimerig"
  }
}