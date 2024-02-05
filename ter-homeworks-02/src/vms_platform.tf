variable "project" {
  type        = string
  description = "vm project name"
  default     = "netology"
}

variable "env" {
  type        = string
  description = "vm env name"
  default     = "develop"
}

variable "resource" {
  type        = string
  description = "vm resource name"
  default     = "platform"
}

variable "vm_serial_port" {
  type        = number
  description = "vm db serial port"
  default     = 1
}

variable "vms_resources" {
    type = map(map(number))
    description = "vms resources"
    default = { 
        db = {
            "cores" = 2,
            "memory" = 2,
            "core_fraction" = 20
            },
            web = {
            "cores" = 2,
            "memory" = 1,
        "core_fraction" = 20
    }
    }
}

### vm-1 vars

variable "vm_web_name" {
  type        = string
  description = "vm web name"
  default     = "web"
}

variable "vm_web_platform" {
  type        = string
  description = "vm platform name"
  default     = "platform"
}


variable "vm_web_platform_id" {
  type        = string
  description = "vm platform id"
  default     = "standard-v3"
}

# variable "vm_web_resources" {
#     type = map(number)
#     description = "vm web resources"
#     default = {
#       "cores" = 2,
#       "memory" = 1,
#       "core_fraction" = 20
#     }
  
# }

# Перемещено в переменную vms_resources

# variable "vm_web_resources_cores" {
#   type        = number
#   description = "vm number of cores"
#   default     = 2
# }

# variable "vm_web_resources_memory" {
#   type        = number
#   description = "vm number of memory"
#   default     = 1
# }

# variable "vm_web_resources_core_fraction" {
#   type        = number
#   description = "vm core fraction"
#   default     = 20
# }

variable "vm_web_preemtable" {
  type        = bool
  description = "preemtable vm"
  default     = true
}

variable "vm_web_nat" {
  type        = bool
  description = "vm nat"
  default     = true
}

### vm-2 vars

variable "vm_db_name" {
  type        = string
  description = "vm db name"
  default     = "db"
}

variable "vm_db_platform_id" {
  type        = string
  description = "vm db platform id"
  default     = "standard-v3"
}

# Перемещено в переменную vms_resources

# variable "vm_db_resources_cores" {
#   type        = number
#   description = "vm db number of cores"
#   default     = 2
# }

# variable "vm_db_resources_memory" {
#   type        = number
#   description = "vm db number of memory"
#   default     = 2
# }

# variable "vm_db_resources_core_fraction" {
#   type        = number
#   description = "vm db core fraction"
#   default     = 20
# }

variable "vm_db_preemtable" {
  type        = bool
  description = "preemtable vm db"
  default     = true
}

variable "vm_db_nat" {
  type        = bool
  description = "vm db nat"
  default     = true
}

variable "vm_db_zone" {
  type        = string
  description = "vm db name"
  default     = "ru-central1-b"
}
