module "develop-vpc" {
  source         = "./vpc"
  name           = var.vpc_name
  zone           = var.default_zone
  v4_cidr_blocks = var.default_cidr

}

module "marketing-vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  # env_name       = "develop"
  network_id     = module.develop-vpc.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.develop-vpc.subnet_id]
  instance_name  = "marketing-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = { "project" : "marketing" }

  metadata = {
    user-data          = data.template_file.cloud-init.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  # env_name       = "stage"
  network_id     = module.develop-vpc.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.develop-vpc.subnet_id]
  instance_name  = "analytics-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = { "project" : "analytics" }

  metadata = {
    user-data          = data.template_file.cloud-init.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
