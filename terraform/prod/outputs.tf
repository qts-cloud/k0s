output "this" {
  description = "This module's main resource: `proxmox_lxc.this`"
  value       = try(module.k0s-cluster, {})
  sensitive   = true
}
