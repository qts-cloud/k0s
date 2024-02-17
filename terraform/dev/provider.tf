provider "proxmox" {
  pm_api_url      = "https://qnap.qts.one:8006/api2/json"
  pm_tls_insecure = true
  pm_parallel     = 4
  pm_timeout      = 300
  pm_log_enable   = false

  # Requirements:
  # export PM_API_TOKEN_ID=
  # export PM_API_TOKEN_SECRET=
}