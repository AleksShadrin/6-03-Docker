# Домашнее задание к занятию «Подъём инфраструктуры в Yandex Cloud»

### Задание 1 

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

От заказчика получено задание: при помощи Terraform и Ansible собрать виртуальную инфраструктуру и развернуть на ней веб-ресурс. 

В инфраструктуре нужна одна машина с ПО ОС Linux, двумя ядрами и двумя гигабайтами оперативной памяти. 

Требуется установить nginx, залить при помощи Ansible конфигурационные файлы nginx и веб-ресурса. 

Для выполнения этого задания нужно сгенирировать SSH-ключ командой ssh-kengen. Добавить в конфигурацию Terraform ключ в поле:

### Конфиги terraform:

### main.tf

    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }
    provider "yandex" {
      token     = "y0_-OCUj23SI0U"
      cloud_id  = "1g7ir1q4u3s"
      folder_id = "b1gle4pc3"
      zone = "ru-central1-a"
    }

### meta.yaml:
    #cloud-config
    users:
      - name: user
        groups: sudo
        shell: /bin/bash
        sudo: [ALL=(ALL) NOPASSWD:ALL]
        ssh_authorized_keys:
            - ssh-rsa AAAAB3NzaC1 root@bullseye

    timezone: europe/moscow
    package_update : true
    packages:
      - nginx
    runcmd:
      - [systemctl, nginx-reload]
      - [systemctl, enable, nginx.service]
      - [systemctl, --no-block, nginx.service]

### create-vm.tf

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

### Конфиги ansible
### hosts.yaml

    all:
      hosts: 51.250.79.133


### copy-index.yaml

    ---
    - name: copy index
      hosts: 51.250.79.133
      become: yes
      become_method: sudo
      remote_user: user
      tasks:
        - name: copy index
          template:
            dest: /var/www/html/index.nginx-debian.html
            src: index.html.j2
    ...

### index.html.j2

    <h1>Comp {{ ansible_fqdn }} params:</h1>
    <h2>CPU: {{ ansible_processor }}</h2>
    <h2>RAM: {{ ansible_memory_mb['real']['total'] }} MB</h2>
    <h2>ip address: {{ ansible_all_ipv4_addresses[0] }}</h2>

![](https://github.com/AleksShadrin/netology/tree/main/7-03-TerraformPart2/screenshots/1.png)
![](https://github.com/AleksShadrin/netology/tree/main/7-03-TerraformPart2/screenshots/2.png)

