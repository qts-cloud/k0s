module "k0s-cluster" {
  source  = "app.terraform.io/qts/lxc-cluster/proxmox"
  version = "1.0.2"

  config = {
    hostname_prefix = "k0s"
    public_key      = var.ssh_public_key
    private_key     = var.ssh_private_key

    targets = [
      {
        host = "hp-01"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "192.168.1.61/24", gw = "192.168.1.1", hwaddr = "BC:24:11:1E:84:BA" },
          { name = "eth1", bridge = "vmbr1", ip = "10.100.10.101/24" }
        ]
      },
      {
        host = "hp-02"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "192.168.1.62/24", gw = "192.168.1.1", hwaddr = "BC:24:11:9F:EC:D8" },
          { name = "eth1", bridge = "vmbr1", ip = "10.100.10.102/24" }
        ]
      },
      {
        host = "hp-03"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "192.168.1.63/24", gw = "192.168.1.1", hwaddr = "BC:24:11:E9:E7:A6" },
          { name = "eth1", bridge = "vmbr1", ip = "10.100.10.103/24" }
        ]
      }
    ]

    lxc_config = {
      ostemplate = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"

      cores  = 4
      memory = 4096
      swap   = 0

      rootfs = {
        storage = "local-lvm"
        size    = "32G"
      }

      start  = true
      onboot = true
      tags   = "lxc;terraform"

      unprivileged = false

      features = {
        nesting = true
      }
    }
  }
}
