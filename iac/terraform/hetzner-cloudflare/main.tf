module "ssh_key_utr_lab" {
  source = "git::https://gitlab.k3s0.ujstor.com/devops/terraform/terraform-hetzner-modules//modules/ssh_key?ref=v0.0.8"

  ssh_key_name = "utr_lab_hetzner_ssh_key"
  ssh_key_path = ".ssh" #create dir before appling tf config if you use custom paths for ssh keys
}

module "utr_lab" {
  source = "git::https://gitlab.k3s0.ujstor.com/devops/terraform/terraform-hetzner-modules//modules/server?ref=v0.0.8"

  server_config = {
    utr-lab-k8s0 = {
      location     = "nbg1"
      server_type  = "cx32"
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id.subnet-1.subnet_id
      subnet_ip    = "10.0.2.1"
      labels = {
        cluster = "lab-k8s0"
      }
    }
  }

  use_network       = true
  hcloud_ssh_key_id = [module.ssh_key_utr_lab.hcloud_ssh_key_id]

  depends_on = [
    module.ssh_key_utr_lab,
    module.network_config
  ]
}

module "network_config" {
  source = "git::https://gitlab.k3s0.ujstor.com/devops/terraform/terraform-hetzner-modules//modules/network/vpc_subnet?ref=v0.0.8"

  vpc_config = {
    vpc_name     = "cluster-vpc"
    vpc_ip_range = "10.0.0.0/16"
  }

  subnet_config = {
    subnet-1 = {
      subnet_ip_range = "10.0.1.0/24"
    }
    subnet-2 = {
      subnet_ip_range = "10.0.2.0/24"
    }
  }

  network_type = "cloud"
  network_zone = "eu-central"
}
