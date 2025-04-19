locals {
  private_key = file("~/.ssh/id_rsa")
  public_key  = file("~/.ssh/id_rsa.pub")
}


module "cluster" {
  source = "git::https://github.com/qtsone/proxmox-k0s-cluster.git?ref=v1.3.2"

  config = {
    name        = "k0s-tm"
    public_key  = local.public_key
    private_key = local.private_key
    ip_subnet   = "10.10.1.0/24"
    gateway     = "10.10.1.1"
    ip_offset   = 40
  }

  proxmox = {
    nodes     = ["mini-01"]
    datastore = "local"
    domain    = "lan"
  }

  os = {
    distro  = "debian"
    version = "12"
  }

  controllers = {
    count           = 1
    worker          = true
    deployment_type = "lxc"
    cpu_cores       = 10
    cpu_units       = 1024
    memory          = 20480
    datastore_id    = "local-zfs"
    disk_size       = 100
    mounts = [
      {
        src_path   = "local-zfs"
        dst_path   = "/data"
        size = "200G"
        replicate  = true
        mount_options = ["discard", "lazytime"]
      }
    ]
    bridge   = "vmbr10"
  }

  workers = {
    count           = 0
  }
}
