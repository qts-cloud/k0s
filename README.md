# Manage k0s Cluster

## Pre-Requisites

1. Terraform installed
1. Proxmox Cluster setup
1. Passwordless SSH authentication to each of the Proxmox nodes using a private key (ex: `~/.ssh/id_rsa`).
   Ex: `ssh root@node-1`
1. Ensure the base LXC template (ex: `ubuntu-22.04-standard_22.04-1_amd64.tar.zst`) is already downloaded in every Proxmox node.

## Pull this repository

```sh
git clone https://github.com/qts-cloud/k0s.git
cd k0s
```

## Modify Nodes Configuration

1. You can alter the existing configuration as needed. Number of nodes, the IPs and more
2. Pay special attention to `rootfs.storage` and the network configuration as it will be required in the next step
3. If DHCP is used for primary network, you will need to ensure the DHCP server can properly resolve the hostnames.
4. If DHCP was not used, you need to update the k0sctl configuration

## Setup the LXC Nodes

```sh
cd terraform/dev

# Export SSH Key paths (both private and public). Will be reused for configuring node access
export TF_VAR_ssh_private_key=$(cat ~/.ssh/id_rsa)
export TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)

# Proxmox API URL
export TF_VAR_api_url=https://<any-node-of-the-cluster>:8006/api2/json

# Proxmox User & Password
export PM_USER=root@pam
export PM_PASS='<ui-node-password>'

terraform init
terraform plan -out tf.p
terraform apply tf.p
```

## Deploy k0s

Ensure you update the k0sctl config before proceeding. In the example we'll use `dev.yaml`
```sh
# Assuming you're in the repository root
k0sctl apply --config dev.yaml

# After deployment finished successfully you need to export the kubeconfig
k0sctl kubeconfig --config dev.yaml > ~/.kube/k0s.dev
export KUBECONFIG=~/.kube/k0s.dev

# Check nodes
kubectl get nodes
```
