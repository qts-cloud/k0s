module "k0s-cluster" {
  source = "../modules/lxc-cluster"

  config = {
    hostname_prefix = "k0s"
    targets         = ["hp-01", "hp-02", "hp-03"]

    node = {
      cores  = 2
      memory = 2048
      swap   = 0
      start  = true
      tags   = "lxc, terraform"

      ostype          = "debian"
      ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
      password        = "change-me"
      ssh_public_keys = data.local_file.public_key.content

      unprivileged    = true
      features = {
        nesting = true
      }

      rootfs = {
        storage = "pve_storage"
        size    = "32G"
      }

      network = [{
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "dhcp"
      }]
    }

  }
}
