resource "random_password" "root" {
  count = try(coalesce(var.config.password), null) != null ? 0 : 1

  length           = 15
  special          = true
  override_special = "!@#$%&*-_=+"
}
