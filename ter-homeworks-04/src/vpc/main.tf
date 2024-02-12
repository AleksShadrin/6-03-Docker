resource "yandex_vpc_network" "network" {
  name = var.name
}
resource "yandex_vpc_subnet" "subnet" {
  name           = var.name
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.v4_cidr_blocks
}