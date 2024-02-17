data "local_file" "public_key" {
  filename = pathexpand(var.public_key_path)
}
