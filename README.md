# Terraform KVM (libvirt) Virtual Machine

## Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)

## Introduction

This module will configure a single libvirt virtual machine with minimal configuration done using [cloud-init](https://cloudinit.readthedocs.io/en/latest/). By default, the virtual machine is configured with the following specifications.

- vCPU: 1
- RAM: 2 GB
- Disk: 20 GB

The virtual machine's IP is statically assigned using variables provided, only one IP is currently supported. When specified, admin users are created with passwordless sudo privileges.

## Usage

### Minimum configuration
```hcl
module "example" {
  source  = "eyulf/libvirt-virtual-machine/module"
  version = "1.0.0"

  providers = {
    libvirt = libvirt
  }

  hostname = "example"
  domain   = "fqdn.name"

  cloudinit_pool_name = libvirt_pool.example.name
  disk_base_volume_id = libvirt_volume.example.id

  network_ip_address     = "192.168.1.20"
  network_gateway_ip     = "192.168.1.1"

  host_root_password = "my-super-awesome-password"
}
```

### Full example
```hcl
provider "libvirt" {
  alias = "kvm1"
  uri   = "qemu+ssh://root@192.168.1.10/system"
}

resource "libvirt_pool" "example" {
  name = "default"
  type = "dir"
  path = "/var/lib/libvirt/images"
}

resource "libvirt_network" "example" {
  name      = "default"
  mode      = "nat"
  domain    = "default"
  addresses = ["0.0.0.0/0"]
  autostart = true
}

resource "libvirt_volume" "example" {
  name   = "debian_10.qcow2"
  pool   = libvirt_pool.example.name
  source = "https://cloud.debian.org/images/cloud/buster/20210208-542/debian-10-genericcloud-amd64-20210208-542.qcow2"
  format = "qcow2"
}

###

module "example" {
  source  = "eyulf/libvirt-virtual-machine/module"
  version = "1.0.0"

  providers = {
    libvirt = libvirt
  }

  hostname = "example"
  domain   = "fqdn.name"

  cloudinit_pool_name = libvirt_pool.example.name
  disk_base_volume_id = libvirt_volume.example.id

  disk_size = 42949652480 # 40 GB
  additional_disks = {
    "disk-name-2" = 1073741312 , # 1 GB
    "disk-name-3" = 429496524800, # 400 GB
  }

  vcpus  = 4
  memory = "8192" # 8 GB

  network_bridge_name    = "br1"
  network_ip_address     = "192.168.1.20"
  network_subnet         = "25"
  network_gateway_ip     = "192.168.1.1"
  network_nameserver_ips = "192.168.1.1, 1.1.1.1, 1.0.0.1"

  host_root_password = "my-super-awesome-password"
  host_admin_users   = {
    "admin" = "ssh-rsa AA[...]ZZ==",
    "admin2" = "ssh-rsa BB[...]YY==",
  }
  host_admin_groups = "wheel,admins"
}
```

---

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| libvirt | >= 0.6.14 |

## Providers

| Name | Version |
|------|---------|
| libvirt | >= 0.6.14 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [libvirt_cloudinit_disk](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.14/docs/resources/cloudinit_disk) |
| [libvirt_domain](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.14/docs/resources/domain) |
| [libvirt_volume](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.14/docs/resources/volume) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_disks | A map of additional disks with their size in Bytes. | `map(number)` | `{}` | no |
| cloudinit\_pool\_name | The pool used to build the CloudInit image. | `string` | n/a | yes |
| disk\_base\_volume\_id | The ID of the disk's base image. | `string` | n/a | yes |
| disk\_size | The size of the VM's disk in Bytes. | `number` | `21474826240` | no |
| domain | The VM's domain that forms the FQDN. | `string` | n/a | yes |
| host\_admin\_groups | A comma seperated string of groups to add admin users to. | `string` | `"wheel"` | no |
| host\_admin\_users | A map of admin users to configure with their SSH Key. | `map(string)` | `{}` | no |
| host\_root\_password | The intial root password. | `string` | n/a | yes |
| hostname | The VM's hostname that forms the FQDN. | `string` | n/a | yes |
| memory | The amount of RAM in MB. | `string` | `"2048"` | no |
| network\_bridge\_name | The name of the Network Bridge. | `string` | `"br0"` | no |
| network\_gateway\_ip | A string of the network's gateway IP. | `string` | n/a | yes |
| network\_ip\_address | The IP Address to use for the network config. | `string` | n/a | yes |
| network\_nameserver\_ips | A comma seperated string of nameserver IPs. | `string` | `"127.0.0.1"` | no |
| network\_subnet | The subnet mask used by the network. | `string` | `"24"` | no |
| vcpus | The number of Virtual CPUs. | `number` | `1` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
