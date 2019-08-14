#single Node
variable "single_node_hostname_ip" {
  type = "map"
}

variable "single_node_vcpu" {
  type    = "string"
}

variable "single_node_memory" {
  type    = "string"
}

variable "single_node_disk1_size" {
  type = "string"
}

variable "single_node_disk1_keep_on_remove" {
  type = "string"
}

variable "vm_ipv4_gateway" {
  type = "string"
}

variable "vm_ipv4_netmask" {
  type = "string"
}

variable "vm_domain_name" {
  type = "string"
}

variable "network" {
  type = "string"
}

variable "adapter_type" {
  type    = "string"
}

variable "vm_folder" {
  type = "string"
}

variable "dns_servers" {
  type = "list"
}

variable "dns_suffixes" {
  type = "list"
}

variable "vm_clone_timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
}

variable "datacenter" {
  type = "string"
}

variable "resource_pool" {
  type = "string"
}

variable "vm_image_template" {
  type = "string"
}

variable "vm_os_user" {
  type = "string"
}

variable "vm_os_password" {
  type = "string"
}

variable "datastore" {
  type = "string"
}

# SSH KEY Information
variable "vm_os_private_ssh_key" {
  type = "string"
}

variable "vm_os_public_ssh_key" {
  type = "string"
}

variable "rh_user" {
  type = "string"
}

variable "rh_password" {
  type = "string"
}

variable "openshift_user" {
  type = "string"
}

variable "openshift_password" {
  type = "string"
}