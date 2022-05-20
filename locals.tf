locals {
  fqdn               = "${var.hostname}.${var.domain}"
  cloudinit_template = "main_config.cfg"
}
