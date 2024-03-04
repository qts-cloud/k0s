variable "api_url" {
  description = "Proxmox API url. Ex: https://<host-ip>:8006/api2/json"
}

variable "private_key" {
  description = "Private SSH Key"
  sensitive   = true
}

variable "public_key" {
  description = "Public SSH Key"
  sensitive   = true
}
