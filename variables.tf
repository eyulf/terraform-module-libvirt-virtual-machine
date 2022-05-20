variable "hostname" {
  description = "The VM's hostname that forms the FQDN."
  type        = string
}

variable "domain" {
  description = "The VM's domain that forms the FQDN."
  type        = string
}

variable "cloudinit_pool_name" {
  description = "The pool used to build the CloudInit image."
  type        = string
}

variable "disk_base_volume_id" {
  description = "The ID of the disk's base image."
  type        = string
}

variable "disk_size" {
  description = "The size of the VM's disk in Bytes."
  default     = 21474826240 # 20 GB
  type        = number
}

variable "additional_disks" {
  description = "A map of additional disks with their size in Bytes."
  default     = {}
  type        = map(number)
}

variable "vcpus" {
  description = "The number of Virtual CPUs."
  default     = 1
  type        = number
}

variable "memory" {
  description = "The amount of RAM in MB."
  default     = "2048"
  type        = string
}

variable "network_bridge_name" {
  description = "The name of the Network Bridge."
  default     = "br0"
  type        = string
}

variable "network_ip_address" {
  description = "The IP Address to use for the network config."
  type        = string
}

variable "network_subnet" {
  description = "The subnet mask used by the network."
  default     = "24"
  type        = string
}

variable "network_gateway_ip" {
  description = "A string of the network's gateway IP."
  type        = string
}

variable "network_nameserver_ips" {
  description = "A comma seperated string of nameserver IPs."
  default     = "127.0.0.1"
  type        = string
}

variable "host_root_password" {
  description = "The intial root password."
  type        = string
}

variable "host_admin_users" {
  description = "A map of admin users to configure with their SSH Key."
  default     = {}
  type        = map(string)
}

variable "host_admin_groups" {
  description = "A comma seperated string of groups to add admin users to."
  default     = "wheel"
  type        = string
}
