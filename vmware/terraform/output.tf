locals {
  fqdn = "${element(keys(var.single_node_hostname_ip),0)}.${var.vm_domain_name}"
}

output "openshift_url" {
  value = "https://${local.fqdn}:8443"
}

output "cluster_name" {
  value = "${replace(local.fqdn,".","-")}"
}
output "openshift_user" {
  value = "${var.openshift_user}"
}

output "openshift_password" {
  value = "${var.openshift_password}"
}

output "openshift_single_node_ip" {
  value = "${element(values(var.single_node_hostname_ip),0)}"
}