terraform {
  cloud {
    organization = "qts"

    workspaces {
      name = "k0s"
    }
  }

  required_version = ">= 1.1.2"
}
