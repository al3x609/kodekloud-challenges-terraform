## provider.ts
provider "kubernetes" {
  config_context_cluster = "kubernetes"
  config_path    = "/root/.kube/config"
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

