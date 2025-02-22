terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
  required_version = ">= 0.13"
}

provider "docker" {
  host     = "ssh://aleks@${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}:22"
  # ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name                      = "vm-1"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd89iq8mqvli97d9poej"
      size     = 10
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("/mnt/shared/terraform/metadata.txt")}"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

resource "docker_image" "mysql" {
  name = "mysql:8"
  build {
    context        = "."
    remote_context = "https://github.com/mysql/mysql-docker.git"
  }
}

resource "docker_container" "mysql"{
  image = docker_image.mysql.image_id
  name  = "mysql-netology"
  env = [
      "MYSQL_ROOT_PASSWORD=${random_password.MYSQL_ROOT_PASSWORD.result}",
      "MYSQL_DATABASE=wordpress",
      "MYSQL_USER=wordpress",
      "MYSQL_PASSWORD=${random_password.MYSQL_PASSWORD.result}",
      "MYSQL_ROOT_HOST=\"%\""
  ]

}

resource "random_password" "MYSQL_ROOT_PASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "MYSQL_PASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}