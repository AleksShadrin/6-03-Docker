variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology"
  description = "VPC network&subnet name"
}

variable "vm_family" {
  type        = string
  description = "vm os family"
  default     = "centos-7"
}

variable "vm_names" {
  type        = set(string)
  default     = ["lighthouse", "clickhouse", "vector"]
  description = "example prefix"
}

variable "vms_params" {
  type        = object({ resources = map(number), preemptible = bool, nat = bool })
  description = "vm_web_description"
  default = {
    resources = {
      cores         = 2
      memory        = 4
      core_fraction = 5
    }
    preemptible = true
    nat         = true
  }
}
