output "external_ip_instance-1" {
  value = yandex_compute_instance.instance-1.network_interface.0.nat_ip_address
}