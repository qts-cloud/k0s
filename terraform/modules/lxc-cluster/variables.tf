variable "config" {
  description = "Configure Cluster Container"
  type = object({
    hostname_prefix = string
    targets = list(string)
    # (Optional) See [lxc](../lxc/README.md) module for possible arguments.
    node = any
  })
}
