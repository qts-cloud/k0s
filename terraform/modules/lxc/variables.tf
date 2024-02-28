variable "config" {
  description = "Configure LXC Container"
  type = object({
    # (Required) A string containing the cluster node name.
    target_node = string
    # (Required) The volume identifier that points to the OS template or backup file.
    ostemplate = optional(string)
    # (Optional) Sets the container OS architecture type. Default is "amd64".
    arch = optional(string)
    # (Optional) A number for setting the override I/O bandwidth limit (in KiB/s).
    bwlimit = optional(number)
    # (Optional) The lxc vmid to clone
    clone = optional(string)
    # (Optional) Target storage for full clone.
    clone_storage = optional(string)
    # (Optional) Configures console mode. "tty" tries to open a connection to one of the available tty devices. "console" tries to attach to /dev/console instead. "shell" simply invokes a shell inside the container (no login). Default is "tty".
    cmode = optional(string)
    # (Optional) A boolean to attach a console device to the container. Default is true.
    console = optional(string)
    # (Optional) The number of cores assigned to the container. A container can use all available cores by default.
    cores = optional(string)
    # (Optional) A number to limit CPU usage by. Default is 0.
    cpulimit = optional(string)
    # (Optional) A number of the CPU weight that the container possesses. Default is 1024.
    cpuunits = optional(string)
    # (Optional) Sets the container description seen in the web interface.
    description = optional(string)
    # (Optional) An object for allowing the container to access advanced features.
    features = optional(object({
      # (Optional) A boolean for enabling FUSE mounts.
      fuse = optional(bool)
      # (Optional) A boolean for enabling the keyctl() system call.
      keyctl = optional(bool)
      # (Optional) Defines the filesystem types (separated by semicolons) that are allowed to be mounted.
      mount = optional(string)
      # (Optional) A boolean to allow nested virtualization.
      nesting = optional(bool)
    }))
    # (Optional) A boolean that allows the overwriting of pre-existing containers.
    force = optional(bool)
    # (Optional) When cloning, create a full copy of all disks. This is always done when you clone a normal CT. For CT template it creates a linked clone by default.
    full = optional(bool)
    # (Optional) Requested HA state for the resource. One of "started", "stopped", "enabled", "disabled", or "ignored". See the docs about HA for more info.
    hastate = optional(string)
    # (Optional) The HA group identifier the resource belongs to (requires hastate to be set!). See the docs about HA for more info.
    hagroup = optional(string)
    # (Optional) A string containing a volume identifier to a script that will be executed during various steps throughout the container's lifetime. The script must be an executable file.
    hookscript = optional(string)
    # (Required) Specifies the host name of the container.
    hostname = string
    # (Optional) A boolean that determines if template extraction errors are ignored during container creation.
    ignore_unpack_errors = optional(bool)
    # (Optional) A string for locking or unlocking the VM.
    lock = optional(string)
    # (Optional) A number containing the amount of RAM to assign to the container (in MB).
    memory = optional(number)

    # (Optional) An object for defining a volume to use as a container mount point. Can be specified multiple times.
    mountpoint = optional(list(object({
      # (Required) The path to the mount point as seen from inside the container. The path must not contain symlinks for security reasons.
      mp = string
      # (Required) Size of the underlying volume. Must end in T, G, M, or K (e.g. "1T", "1G", "1024M" , "1048576K"). Note that this is a read only value.
      size = string
      # (Required) A string containing the number that identifies the mount point (i.e. the n in mp[n]).
      slot = string
      # (Required) The number that identifies the mount point (i.e. the n in mp[n]).
      key = number
      # (Required) A string containing the volume , directory, or device to be mounted into the container (at the path specified by mp). E.g. local-lvm, local-zfs, local etc.
      storage = string
      # (Optional) A boolean for enabling ACL support. Default is false.
      acl = optional(bool)
      # (Optional) A boolean for including the mount point in backups. Default is false.
      backup = optional(bool)
      # (Optional) A boolean for enabling user quotas inside the container for this mount point. Default is false.
      quota = optional(bool)
      # (Optional) A boolean for including this volume in a storage replica job. Default is false.
      replicate = optional(bool)
      # (Optional) A boolean for marking the volume as available on all nodes. Default is false.
      shared = optional(bool)
    })))

    # (Optional) An object defining a network interface for the container. Can be specified multiple times.
    network = optional(list(object({
      # (Required)  = optional(string) The name of the network interface as seen from inside the container (e.g. "eth0").
      name = string
      # (Optional) The bridge to attach the network interface to (e.g. "vmbr0").
      bridge = optional(string)
      # (Optional) A boolean to enable the firewall on the network interface.
      firewall = optional(bool)
      # (Optional) The IPv4 address belonging to the network interface's default gateway.
      gw = optional(string)
      # (Optional) The IPv6 address of the network interface's default gateway.
      gw6 = optional(string)
      # (Optional) A string to set a common MAC address with the I/G (Individual/Group) bit not set. Automatically determined if not set.
      hwaddr = optional(string)
      # (Optional) The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), "dhcp", or "manual". Default "dhcp".
      ip = optional(string)
      # (Optional) The IPv6 address of the network interface. Can be a static IPv6 address (in CIDR notation), "auto" , "dhcp", or "manual".
      ip6 = optional(string)
      # (Optional) A string to set the MTU on the network interface.
      mtu = optional(string)
      # (Optional) A number that sets rate limiting on the network interface (Mbps).
      rate = optional(string)
      # (Optional) A number that specifies the VLAN tag of the network interface. Automatically determined if not set.
      tag = optional(string)
    })))

    # (Optional) A boolean that determines if the container will start on boot. Default is false.
    onboot = optional(bool)
    # (Optional) The operating system type, used by LXC to set up and configure the container. Automatically determined if not set.
    ostype = optional(string)
    # (Optional) Sets the root password inside the container.
    password = optional(string)
    # (Optional) The name of the Proxmox resource pool to add this container to.
    pool = optional(string)
    # (Optional) A boolean that enables the protection flag on this container. Stops the container and its disk from being removed/updated. Default is false.
    protection = optional(bool)
    # (Optional) A boolean to mark the container creation/update as a restore task.
    restore = optional(bool)
    # (Optional) An object for configuring the root mount point of the container. Can only be specified once.
    rootfs = optional(object({
      # (Required) Size of the underlying volume. Must end in T, G, M, or K (e.g. "1T", "1G", "1024M" , "1048576K"). Note that this is a read only value.
      size = string
      # (Required) A string containing the volume , directory, or device to be mounted into the container (at the path specified by mp). E.g. local-lvm, local-zfs, local etc.
      storage = string
    }))

    # (Optional) The DNS server IP address used by the container. If neither nameserver nor searchdomain are specified, the values of the Proxmox host will be used by default.
    nameserver = optional(string)
    # (Optional) Sets the DNS search domains for the container. If neither nameserver nor searchdomain are specified, the values of the Proxmox host will be used by default.
    searchdomain = optional(string)
    # (Optional) Multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax.
    ssh_public_keys = optional(string)
    # (Optional) A boolean that determines if the container is started after creation. Default is false.
    start = optional(bool)
    # (Optional) The startup and shutdown behaviour of the container.
    startup = optional(string)
    # (Optional) A number that sets the amount of swap memory available to the container. Default is 512.
    swap = optional(number)
    # (Optional) Tags of the container. This is only meta information.
    tags = optional(string)
    # (Optional) A boolean that determines if this container is a template.
    template = optional(bool)
    # (Optional) A number that specifies the TTYs available to the container. Default is 2.
    tty = optional(number)
    # (Optional) A boolean that determines if a unique random ethernet address is assigned to the container.
    unique = optional(bool)
    # (Optional) A boolean that makes the container run as an unprivileged user. Default is true.
    unprivileged = optional(bool)
    # (Optional) A number that sets the VMID of the container. If set to 0, the next available VMID is used. Default is 0.
    vmid = optional(number)
  })
}
