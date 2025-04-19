output "results" {
  value = {
    iso_url = module.cluster.iso_url
    lxc_url = module.cluster.lxc_url
  }
}

output "controllers" {
  value     = module.cluster.controllers
  sensitive = false
}

output "workers" {
  value     = module.cluster.workers
  sensitive = false
}
