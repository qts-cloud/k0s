module "k0s-cluster" {
  source = "git::https://github.com/qts-cloud/terraform-proxmox-lxc-cluster.git?ref=v1.1.0"

  config = {
    hostname_prefix = "k0s-prod"
    public_key      = var.ssh_public_key
    private_key     = var.ssh_private_key

    targets = [
      {
        host = "hp-01"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "dhcp", gw = "10.0.2.1" },
          { name = "eth1", bridge = "vmbr10", ip = "10.10.2.201/24" }
        ]
      },
      {
        host = "hp-02"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "dhcp", gw = "10.0.2.1" },
          { name = "eth1", bridge = "vmbr10", ip = "10.10.2.202/24" }
        ]
      },
      {
        host = "hp-03"
        network = [
          { name = "eth0", bridge = "vmbr0", ip = "dhcp", gw = "10.0.2.1" },
          { name = "eth1", bridge = "vmbr10", ip = "10.10.2.203/24" }
        ]
      }
    ]

    lxc_config = {
      # ostemplate = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
      ostemplate = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

      cores  = 4
      memory = 10240
      swap   = 0

      rootfs = {
        storage = "nvme"
        size    = "100G"
      }

      start  = true
      onboot = true
      tags   = "lxc;terraform;k8s"

      unprivileged = false

      features = {
        nesting = true
      }
    }
  }
}
