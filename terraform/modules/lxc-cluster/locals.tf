locals {
  hostname_prefix = try(coalesce(var.config.hostname_prefix), null)
  targets         = try(coalesce(var.config.targets), [])
  node            = try(coalesce(var.config.node), {})

  lxc_unique_topics = ["target_node", "hostname"]
  lxc = {
    for i, target in local.targets :
    "${local.hostname_prefix}-${i + 1}" => {
      config = merge(
        local.node,
        {
          hostname    = "${local.hostname_prefix}-${i + 1}"
          target_node = target
        }
      )
    }
  }
}
