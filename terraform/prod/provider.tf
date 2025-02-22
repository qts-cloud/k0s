provider "proxmox" {
  pm_api_url      = var.api_url
  pm_tls_insecure = true
  pm_parallel     = 1
  pm_timeout      = 300
  pm_log_enable   = false

  # Requirements:
  # export PM_API_TOKEN_ID=
  # export PM_API_TOKEN_SECRET=
}
