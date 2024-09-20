provider "kubernetes" {
    config_path = "/home/ram/.kube/config"
}

resource "kubernetes_manifest" "ng" {
    manifest = yamldecode(file("/home/ram/terraform/terraform_manifest/pod.yaml"))
}
resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("/home/ram/terraform/terraform_manifest/service.yaml"))
}