variable "environment" {
  default = "development"
}

variable "region" {
  default = "ber"
}

variable "dns_root" {
  default = "qts.one"
}

variable "github" {
  type = object({
    organisation     = string
    server_url       = optional(string, "https://github.com")
    application_id   = number
    installation_id  = number
    private_key_path = string
  })
}

variable "secrets" {
  type = list(object({
    name       = string
    namespace  = string
    labels     = optional(map(string))
    data       = optional(map(string))
    stringData = optional(map(string))
  }))
}

