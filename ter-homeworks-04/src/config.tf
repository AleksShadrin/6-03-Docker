data "template_file" "cloud-init" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    username       = var.username
    ssh_public_key = local.ssh_public_key
    packages       = jsonencode(var.packages)
  }
}