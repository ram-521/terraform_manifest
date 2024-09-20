provider "kubernetes" {
    config_path = "~./kube/config"
}
resource "kubernetes_manifest" "ng" {
    manifest = yamldecode("/home/ram/terraform/terraform_manifest/pod.yaml")
  
}