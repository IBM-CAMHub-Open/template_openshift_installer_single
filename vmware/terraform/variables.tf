#single Node
variable "single_hostname_ip" {
  type = "map"
}

variable "single_vcpu" {
  type    = "string"
  default = "4"
}

variable "single_memory" {
  type    = "string"
  default = "8192"
}

variable "single_vm_ipv4_gateway" {
  type = "string"
}

variable "single_vm_ipv4_prefix_length" {
  type = "string"
}

variable "single_vm_disk1_size" {
  type = "string"

  default = "150"
}

variable "single_vm_disk1_keep_on_remove" {
  type = "string"

  default = "false"
}

variable "single_vm_disk2_enable" {
  type = "string"

  default = "false"
}

variable "single_vm_disk2_size" {
  type = "string"

  default = "50"
}

variable "single_vm_disk2_keep_on_remove" {
  type = "string"

  default = "false"
}

# VM Generic Items
variable "vm_domain" {
  type = "string"
}

variable "vm_network_interface_label" {
  type = "string"
}

variable "vm_adapter_type" {
  type    = "string"
  default = "vmxnet3"
}

variable "vm_folder" {
  type = "string"
}

variable "vm_dns_servers" {
  type = "list"
}

variable "vm_dns_suffixes" {
  type = "list"
}

variable "vm_clone_timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  default = "30"
}

variable "vsphere_datacenter" {
  type = "string"
}

variable "vsphere_resource_pool" {
  type = "string"
}

variable "vm_template" {
  type = "string"
}

variable "vm_os_user" {
  type = "string"
}

variable "vm_os_password" {
  type = "string"
}

variable "vm_disk1_datastore" {
  type = "string"
}

variable "vm_disk2_datastore" {
  type = "string"
}

# SSH KEY Information
variable "os_private_ssh_key" {
  type = "string"
  default = ""
}

variable "os_public_ssh_key" {
  type = "string"
  default = ""
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