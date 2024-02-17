resource "proxmox_lxc" "this" {
  target_node   = local.target_node
  ostemplate    = local.ostemplate
  arch          = local.arch
  bwlimit       = local.bwlimit
  clone         = local.clone
  clone_storage = local.clone_storage
  cmode         = local.cmode
  console       = local.console
  cores         = local.cores
  cpulimit      = local.cpulimit
  cpuunits      = local.cpuunits
  description   = local.description

  dynamic "features" {
    for_each = local.features
    content {
      fuse    = features.value.fuse
      keyctl  = features.value.keyctl
      mount   = features.value.mount
      nesting = features.value.nesting
    }
  }

  force                = local.force
  full                 = local.full
  hastate              = local.hastate
  hagroup              = local.hagroup
  hookscript           = local.hookscript
  hostname             = local.hostname
  ignore_unpack_errors = local.ignore_unpack_errors
  lock                 = local.lock
  memory               = local.memory

  dynamic "mountpoint" {
    for_each = local.mountpoint
    content {
      mp        = mountpoint.value.mp
      size      = mountpoint.value.size
      slot      = mountpoint.value.slot
      key       = mountpoint.value.key
      storage   = mountpoint.value.storage
      acl       = mountpoint.value.acl
      backup    = mountpoint.value.backup
      quota     = mountpoint.value.quota
      replicate = mountpoint.value.replicate
      shared    = mountpoint.value.shared
    }
  }

  nameserver = local.nameserver

  dynamic "network" {
    for_each = local.network
    content {
      name     = network.value.name
      bridge   = network.value.bridge
      firewall = network.value.firewall
      gw       = network.value.gw
      gw6      = network.value.gw6
      hwaddr   = network.value.hwaddr
      ip       = network.value.ip
      ip6      = network.value.ip6
      mtu      = network.value.mtu
      rate     = network.value.rate
      tag      = network.value.tag
    }
  }

  onboot     = local.onboot
  ostype     = local.ostype
  password   = local.password
  pool       = local.pool
  protection = local.protection
  restore    = local.restore

  dynamic "rootfs" {
    for_each = local.rootfs
    content {
      size    = rootfs.value.size
      storage = rootfs.value.storage
    }
  }

  searchdomain    = local.searchdomain
  ssh_public_keys = local.ssh_public_keys
  start           = local.start
  startup         = local.startup
  swap            = local.swap
  tags            = local.tags
  template        = local.template
  tty             = local.tty
  unique          = local.unique
  unprivileged    = local.unprivileged
  vmid            = local.vmid
}
