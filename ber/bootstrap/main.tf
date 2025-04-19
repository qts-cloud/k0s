locals {
  private_key = file("~/.ssh/id_rsa")
  public_key  = file("~/.ssh/id_rsa.pub")
}

module "cluster" {
  source = "git::https://github.com/qtsone/proxmox-k0s-cluster.git?ref=v1.3.2"

  config = {
    name        = "k0s-ber"
    public_key  = local.public_key
    private_key = local.private_key
    ip_subnet   = "10.0.2.0/24"
    gateway     = "10.0.2.1"
    ip_offset   = 40
  }

  proxmox = {
    nodes     = ["hp-01", "hp-02", "hp-03"]
    datastore = "local"
    domain    = "ber"
  }

  os = {
    distro  = "debian"
    version = "12"
  }

  # installFlags = ["--disable-components metrics-server"]

  controllers = {
    count           = 1
    worker          = true
    deployment_type = "lxc"
    cpu_cores       = 4
    cpu_units       = 1024
    memory          = 20480
    datastore_id    = "nvme"
    disk_size       = 100
    mounts = [
      {
        src_path   = "nvme"
        dst_path   = "/data"
        size = "200G"
        replicate  = true
        mount_options = ["discard", "lazytime"]
      }
    ]
    bridge   = "vmbr0"
  }

  workers = {
    count           = 2
    worker          = true
    deployment_type = "lxc"
    cpu_cores       = 4
    cpu_units       = 1024
    memory          = 20480
    datastore_id    = "nvme"
    disk_size       = 100
    mounts = [
      {
        src_path   = "nvme"
        dst_path   = "/data"
        size = "200G"
        replicate  = true
        mount_options = ["discard", "lazytime"]
      }
    ]
    bridge   = "vmbr0"
  }
}
