provider "kubernetes" {
  config_path    = "~/.kube/kube-master/.kube/config"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "terraform-example"
  }
}
