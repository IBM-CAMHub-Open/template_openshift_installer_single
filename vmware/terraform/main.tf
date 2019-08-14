provider "vsphere" {
  allow_unverified_ssl = "true"
}

provider "random" {
  version = "~> 1.0"
}

provider "local" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 1.0"
}

provider "tls" {
  version = "~> 1.0"
}

resource "random_string" "random-dir" {
  length  = 8
  special = false
}

resource "tls_private_key" "generate" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "null_resource" "create-temp-random-dir" {
  provisioner "local-exec" {
    command = "${format("mkdir -p  /tmp/%s" , "${random_string.random-dir.result}")}"
  }
}

module "deployVM_single" {
  source = "git::https://github.com/IBM-CAMHub-Open/template_openshift_modules.git?ref=3.11//vmware_provision"

  #######
  datacenter    = "${var.datacenter}"
  resource_pool = "${var.resource_pool}"

  # count                 = "${length(var.single_vm_ipv4_address)}"
  count = "${length(keys(var.single_node_hostname_ip))}"

  #######
  // vm_folder = "${module.createFolder.folderPath}"
  enable_vm               = "true"
  vm_vcpu                 = "${var.single_node_vcpu}"                                                                                                           // vm_number_of_vcpu
  vm_name                 = "${keys(var.single_node_hostname_ip)}"
  vm_memory               = "${var.single_node_memory}"
  vm_image_template       = "${var.vm_image_template}"
  vm_os_password          = "${var.vm_os_password}"
  vm_os_user              = "${var.vm_os_user}"
  vm_domain_name          = "${var.vm_domain_name}"
  vm_folder               = "${var.vm_folder}"
  vm_private_ssh_key      = "${length(var.vm_os_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}"     : "${base64decode(var.vm_os_private_ssh_key)}"}"
  vm_public_ssh_key       = "${length(var.vm_os_public_ssh_key)  == 0 ? "${tls_private_key.generate.public_key_openssh}"  : "${var.vm_os_public_ssh_key}"}"
  network                 = "${var.network}"
  vm_ipv4_gateway         = "${var.vm_ipv4_gateway}"
  vm_ipv4_address         = "${values(var.single_node_hostname_ip)}"
  vm_ipv4_netmask   = "${var.vm_ipv4_netmask}"
  adapter_type            = "${var.adapter_type}"
  vm_disk1_size           = "${var.single_node_disk1_size}"
  vm_disk1_datastore      = "${var.datastore}"
  vm_disk1_keep_on_remove = "${var.single_node_disk1_keep_on_remove}"
  vm_disk2_enable         = "false"
  vm_disk2_size           = "0"
  vm_disk2_datastore      = "${var.datastore}"
  vm_disk2_keep_on_remove = "false"
  dns_servers             = "${var.dns_servers}"
  dns_suffixes            = "${var.dns_suffixes}"
  vm_clone_timeout        = "${var.vm_clone_timeout}"
  random                  = "${random_string.random-dir.result}"

  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"    
}

module "host_prepare" {
  source = "git::https://github.com/IBM-CAMHub-Open/template_openshift_modules.git?ref=3.11//host_prepare"
  
  private_key          = "${length(var.vm_os_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}" : "${base64decode(var.vm_os_private_ssh_key)}"}"
  vm_os_user           = "${var.vm_os_user}"
  vm_os_password       = "${var.vm_os_password}"
  rh_user              = "${var.rh_user}"
  rh_password          = "${var.rh_password}"
  vm_ipv4_address_list = "${values(var.single_node_hostname_ip)}"
  vm_hostname_list     = "${element(values(var.single_node_hostname_ip), 0)}"
  vm_domain_name          = "${var.vm_domain_name}"
  installer_hostname   = "${element(keys(var.single_node_hostname_ip), 0)}"
  compute_hostname     = "${element(keys(var.single_node_hostname_ip), 0)}"
  random               = "${random_string.random-dir.result}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"      
  dependsOn           = "${module.deployVM_single.dependsOn}"
}

module "config_inventory_single" {
  source = "git::https://github.com/IBM-CAMHub-Open/template_openshift_modules.git?ref=3.11//config_inventory_single"
  
  private_key          = "${length(var.vm_os_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}" : "${base64decode(var.vm_os_private_ssh_key)}"}"
  vm_os_user           = "${var.vm_os_user}"
  vm_os_password       = "${var.vm_os_password}"
  vm_domain_name          = "${var.vm_domain_name}"
  single_node_hostname          = "${element(keys(var.single_node_hostname_ip), 0)}"
  single_node_ipv4_address      = "${element(values(var.single_node_hostname_ip), 0)}"
  rh_user                    = "${var.rh_user}"
  rh_password                = "${var.rh_password}"

  random              = "${random_string.random-dir.result}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"      
  dependsOn           = "${module.host_prepare.dependsOn}"
}

module "run_installer" {
  source = "git::https://github.com/IBM-CAMHub-Open/template_openshift_modules.git?ref=3.11//run_installer"
  
  private_key         = "${length(var.vm_os_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}" : "${base64decode(var.vm_os_private_ssh_key)}"}"
  vm_os_user          = "${var.vm_os_user}"
  vm_os_password      = "${var.vm_os_password}"
  master_node_ip      = "${element(values(var.single_node_hostname_ip), 0)}"
  openshift_user      = "${var.openshift_user}"
  openshift_password  = "${var.openshift_password}"

  random              = "${random_string.random-dir.result}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"      
  dependsOn           = "${module.config_inventory_single.dependsOn}"
}