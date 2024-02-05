output "instances" {
  value = [{ instance_name = yandex_compute_instance.platform.name,
            instance_external_ip = yandex_compute_instance.platform.network_interface.0.nat_ip_address,
            instance_fqdn = yandex_compute_instance.platform.fqdn },
            { instance_name = yandex_compute_instance.platform-2.name,
            instance_external_ip = yandex_compute_instance.platform-2.network_interface.0.nat_ip_address,
            instance_fqdn = yandex_compute_instance.platform-2.fqdn }]
}
