module "lxc" {
  source = "../lxc"

  for_each = local.lxc
  config   = each.value.config
}
