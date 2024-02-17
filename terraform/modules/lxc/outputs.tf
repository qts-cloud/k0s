output "this" {
  description = "This module's main resource: `proxmox_lxc.this`"
  value       = try(proxmox_lxc.this, {})
  sensitive   = false
}
