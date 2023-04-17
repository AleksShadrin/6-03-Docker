resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
    
  }
  boot_disk {
    initialize_params {
      image_id = "fd8jvr9ans916ofp7gdg"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("meta.yaml")}"
    serial-port-enable = 1
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
