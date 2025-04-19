terraform {
  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0.9"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.19"
    }
  }
  required_version = "~> 1.3"
}

provider "kubernetes" {
  config_path    = "~/.kube/${local.cluster_name}"
  config_context = "${local.cluster_name}"
}

provider "kustomization" {
  kubeconfig_path = "~/.kube/${local.cluster_name}"
}

provider "kubectl" {
  config_path    = "~/.kube/${local.cluster_name}"
  config_context = "${local.cluster_name}"
}
