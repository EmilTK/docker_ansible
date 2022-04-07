provider "yandex" {
}

locals {
  cores = 2
  memory = 4
  #image_id = "fd8hedriopd1p208elrg" #Centos7
  image_id ="fd8mfc6omiki5govl68h" #Ubuntu20.04LTS
  ssh-keys = "cloud-user:${file("~/.ssh/id_rsa.pub")}"
}

resource "yandex_compute_instance" "instance-1" {
  name = "instance-1"
  platform_id = "standard-v1"

  resources {
    cores  = local.cores
    memory = local.memory
  }

  boot_disk {
    initialize_params {
      image_id = local.image_id 
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  v4_cidr_blocks = ["10.2.0.0/24"]
  network_id     = yandex_vpc_network.network.id
}
