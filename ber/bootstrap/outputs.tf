output "controllers" {
  value     = module.cluster.controllers
  sensitive = false
}

output "workers" {
  value     = module.cluster.workers
  sensitive = false
}
