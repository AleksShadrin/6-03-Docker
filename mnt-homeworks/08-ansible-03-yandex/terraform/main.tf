resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "netology" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "centos" {
  family = var.vm_family
}

resource "yandex_compute_instance" "netology-08" {

  for_each = var.vm_names
  name     = each.key

  resources {
    cores         = var.vms_params.resources.cores
    memory        = var.vms_params.resources.memory
    core_fraction = var.vms_params.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vms_params.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology.id
    nat       = var.vms_params.nat
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
  }
}