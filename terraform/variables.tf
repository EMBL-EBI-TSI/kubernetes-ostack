##Setup needed variables
variable "cluster-name" {}
variable "node-count" {}
variable "floating-ip-pool" {}
variable "image-name" {}
variable "image-flavor" {}
variable "key-pair" {}
variable "ext-router-id" {}

output "master_ip" {
  value = "${openstack_compute_floatingip_v2.master-ip.address}"
}
