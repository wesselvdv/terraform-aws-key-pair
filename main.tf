module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.14.1"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  delimiter  = var.delimiter
  tags       = var.tags
}

locals {
  public_key_filename = format(
    "%s/%s%s",
    var.ssh_public_key_path,
    module.label.id,
    var.public_key_extension
  )

  private_key_filename = format(
    "%s/%s%s",
    var.ssh_public_key_path,
    module.label.id,
    var.private_key_extension
  )
}

resource "tls_private_key" "default" {
  count     = var.generate_ssh_key == true ? 1 : 0
  algorithm = var.ssh_key_algorithm
}

resource "aws_key_pair" "generated" {
  count      = var.generate_ssh_key == true ? 1 : 0
  depends_on = [tls_private_key.default]
  key_name   = module.label.id
  public_key = tls_private_key.default[0].public_key_openssh
}

