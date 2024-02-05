locals {
  vm_web_name = "${var.project}-${var.env}-${var.resource}-${var.vm_web_name}"
  vm_db_name  = "${var.project}-${var.env}-${var.resource}-${var.vm_db_name}"
  metadata = {
    serial-port-enable = var.vm_serial_port
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}