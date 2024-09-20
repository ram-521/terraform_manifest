provider "kubernetes" {
    config_path = "~./kube/config"
}
resource "kubernetes_manifest" "ng" {
    manifest = yamldecode(file("/home/ram/terraform/terraform_manifest/pod.yaml"))
  
}
