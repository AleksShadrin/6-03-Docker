output "network_id" {
    value = yandex_vpc_network.network.id
}

output "network_name" {
    value = yandex_vpc_network.network.name
}

output "subnet_id" {
    value = yandex_vpc_subnet.subnet.id
}

output "subnet_name" {
    value = yandex_vpc_subnet.subnet.name
}

output "subnet_v4_cidr" {
    value = yandex_vpc_subnet.subnet.v4_cidr_blocks
}

output "subnet_zone" {
    value = yandex_vpc_subnet.subnet.zone
}
