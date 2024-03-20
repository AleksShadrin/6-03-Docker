output "vms" {
  value = [[for vm in yandex_compute_instance.netology-08 : {
    instance_name = vm.name,
    instance_ip   = vm.network_interface.0.nat_ip_address
  }]]
}