output "vms" {
  value = [[for vm in concat(yandex_compute_instance.web, values(yandex_compute_instance.db)) : {
    instance_name = vm.name,
    instance_id   = vm.id,
    instance_fqdn = vm.fqdn
  }]]
}