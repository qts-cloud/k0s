terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.74.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.api_url
  username = var.api_username
  password = var.api_password

  insecure = true
  ssh {
    agent       = false
    private_key = local.private_key
  }
}
