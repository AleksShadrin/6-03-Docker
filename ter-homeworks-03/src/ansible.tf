resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.web[*],
      databases  = yandex_compute_instance.db,
      storages   = yandex_compute_instance.storage[*]
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}