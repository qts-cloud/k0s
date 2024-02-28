locals {
  target_node   = try(coalesce(var.config.target_node), null)
  ostemplate    = try(coalesce(var.config.ostemplate), null)
  arch          = try(coalesce(var.config.arch), "amd64")
  bwlimit       = try(coalesce(var.config.bwlimit), null)
  clone         = try(coalesce(var.config.clone), null)
  clone_storage = try(coalesce(var.config.clone_storage), null)
  cmode         = try(coalesce(var.config.cmode), "tty")
  console       = try(coalesce(var.config.console), true)
  cores         = try(coalesce(var.config.cores), null)
  cpulimit      = try(coalesce(var.config.cpulimit), 0)
  cpuunits      = try(coalesce(var.config.cpuunits), 1024)
  description   = try(coalesce(var.config.description), null)

  features = [
    for config in flatten([try(coalesce(var.config.features), [])]) : {
      fuse    = try(config.fuse, null)
      keyctl  = try(config.keyctl, null)
      mount   = try(config.mount, null)
      nesting = try(config.nesting, null)
    }
  ]

  force                = try(coalesce(var.config.force), null)
  full                 = try(coalesce(var.config.full), null)
  hastate              = try(coalesce(var.config.hastate), null)
  hagroup              = try(coalesce(var.config.hagroup), null)
  hookscript           = try(coalesce(var.config.hookscript), null)
  hostname             = try(coalesce(var.config.hostname), null)
  ignore_unpack_errors = try(coalesce(var.config.ignore_unpack_errors), null)
  lock                 = try(coalesce(var.config.lock), null)
  memory               = try(coalesce(var.config.memory), null)

  mountpoint = [
    for config in flatten([try(coalesce(var.config.mountpoint), [])]) : {
      mp        = try(coalesce(config.mp), null)
      size      = try(coalesce(config.size), null)
      slot      = try(coalesce(config.slot), null)
      key       = try(coalesce(config.key), null)
      storage   = try(coalesce(config.storage), null)
      acl       = try(coalesce(config.acl), false)
      backup    = try(coalesce(config.backup), false)
      quota     = try(coalesce(config.quota), false)
      replicate = try(coalesce(config.replicate), false)
      shared    = try(coalesce(config.shared), false)
    }
  ]

  nameserver = try(coalesce(var.config.nameserver), null)

  network = [
    for config in flatten([try(coalesce(var.config.network), [])]) : {
      name     = try(coalesce(config.name), null)
      bridge   = try(coalesce(config.bridge), null)
      firewall = try(coalesce(config.firewall), true)
      gw       = try(coalesce(config.gw), null)
      gw6      = try(coalesce(config.gw6), null)
      hwaddr   = try(coalesce(config.hwaddr), null)
      ip       = try(coalesce(config.ip), "dhcp")
      ip6      = try(coalesce(config.ip6), null)
      mtu      = try(coalesce(config.mtu), null)
      rate     = try(coalesce(config.rate), null)
      tag      = try(coalesce(config.tag), null)
    }
  ]

  onboot     = try(coalesce(var.config.onboot), false)
  ostype     = try(coalesce(var.config.ostype), null)
  password   = sensitive(try(coalesce(var.config.password), random_password.root.0.result))
  pool       = try(coalesce(var.config.pool), null)
  protection = try(coalesce(var.config.protection), false)
  restore    = try(coalesce(var.config.restore), null)

  rootfs = [
    for config in flatten([try(coalesce(var.config.rootfs), [])]) : {
      size    = try(coalesce(config.size), null)
      storage = try(coalesce(config.storage), null)
    }
  ]

  searchdomain    = try(coalesce(var.config.searchdomain), null)
  ssh_public_keys = try(coalesce(var.config.ssh_public_keys), null)
  start           = try(coalesce(var.config.start), false)
  startup         = try(coalesce(var.config.startup), null)
  swap            = try(coalesce(var.config.swap), 512)
  tags            = try(coalesce(var.config.tags), null)
  template        = try(coalesce(var.config.template), null)
  tty             = try(coalesce(var.config.tty), 2)
  unique          = try(coalesce(var.config.unique), null)
  unprivileged    = try(coalesce(var.config.unprivileged), true)
  vmid            = try(coalesce(var.config.vmid), 0)

  remote_exec = [
    for config in flatten([try(coalesce(var.config.remote_exec), [])]) : {
      size    = try(coalesce(config.size), null)
      storage = try(coalesce(config.storage), null)
    }
  ]
}
