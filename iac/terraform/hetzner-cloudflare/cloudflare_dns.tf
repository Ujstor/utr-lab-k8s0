module "cloudflare_record" {
  source = "git::https://gitlab.k3s0.ujstor.com/devops/terraform/terraform-hetzner-modules//modules/network/cloudflare_record?ref=v0.0.8"

  cloudflare_record = {
    kube_api_lab_k8s0 = {
      zone_id = var.cloudflare_zone_id
      name    = "api.utr.lab.k8s0"
      content = module.utr_lab.server_info.utr-lab-k8s0.ip
      type    = "A"
      ttl     = 60
      proxied = false
    }
    wildcard_lab_k8s0 = {
      zone_id = var.cloudflare_zone_id
      name    = "*.utr.lab.k8s0"
      content = module.utr_lab.server_info.utr-lab-k8s0.ip
      type    = "A"
      ttl     = 60
      proxied = false
    }
  }
  depends_on = [module.utr_lab]
}
