resource "yandex_compute_disk" "disks" {
  count = var.disks.count
  name  = "${var.disks.name}-${count.index}"
  type  = var.disks.type
  size  = var.disks.size
}

resource "yandex_compute_instance" "storage" {

  name = var.vm_storage.name

  resources {
    cores         = var.vm_storage.resources.cores
    memory        = var.vm_storage.resources.memory
    core_fraction = var.vm_storage.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks
    content {
      disk_id = lookup(secondary_disk.value, "id", null)
    }
  }

  scheduling_policy {
    preemptible = var.vm_storage.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_storage.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.metadata
}