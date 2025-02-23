# UTR-LAB-K8S0

Minimal k3s single node deployment on Hetzner Cloud with Terraform and Ansible as multi cluster configuration managed with ArgoCD.


K3s is stripped down to minimal components. The only components we have are CoreDNS, local-path-provisioner, and metrics-server. Everything else is disabled and configured with custom Helm charts.

The clusters will be automatically bootstrapped and managed with [ArgoCD](https://argo-cd.readthedocs.io/en/stable/).

## Prerequisites

Before you begin, ensure you have the following:

- [Hetzner Cloud account](https://hetzner.cloud/?ref=Ix9xCKNxJriM) (20$ free credits)
- [Terraform](https://www.terraform.io/downloads.html)
- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [K9s](https://k9scli.io/) (optional but recommended)


Helm charts and Terraform modules are custom-made with the intention to be reusable and reconfigurable:

- [Helm Charts System](https://gitlab.k3s0.ujstor.com/devops/helm/system)
- [Helm Charts Apps](https://gitlab.k3s0.ujstor.com/devops/helm/apps)
- [Helm Charts Github Apps](https://gitlab.k3s0.ujstor.com/devops/helm/github-apps)
- [Terraform Hetzner Modules](https://gitlab.k3s0.ujstor.com/devops/terraform/terraform-hetzner-modules)

## TF module in private repo

```bash
~/.terraformrc

credentials "gitlab.k3s0.ujstor.com" {
  token = "gitlab_token"
}
```

## Ansible

```bash
docker run --rm -it \
    -v $(pwd)/iac/ansible/inventory_k3s_deploy.yml:/config/inventory.yml \
    -v $(pwd)/iac/terraform/hetzner-cloudflare/.ssh/utr_lab_hetzner_ssh_key:/secrets/ssh_key \
    -v $(pwd)/iac/terraform/hetzner-cloudflare/.ssh/utr_lab_hetzner_ssh_key.pub:/secrets/ssh_key.pub \
    harbor.k3s0.ujstor.com/images/k3s-deployment:1.0.0
```
