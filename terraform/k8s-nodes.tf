##Create a single master node and floating IP
resource "openstack_compute_floatingip_v2" "master-ip" {
  pool = "${var.floating-ip-pool}"
}

resource "openstack_compute_instance_v2" "k8s-master" {
  name = "${var.cluster-name}-master"
  image_name = "${var.image-name}"
  flavor_name = "${var.image-flavor}"
  key_pair = "${var.key-pair}"
  security_groups = ["${openstack_compute_secgroup_v2.k8s-security.name}"]
  network {
    name = "${openstack_networking_network_v2.k8s-network.name}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "k8s-fip-ass" {
  floating_ip = "${openstack_compute_floatingip_v2.master-ip.address}"
  instance_id = "${openstack_compute_instance_v2.k8s-master.id}"
}

resource "openstack_compute_instance_v2" "k8s-node" {
  count = "${var.node-count}"
  name = "${var.cluster-name}-node-${count.index}"
  image_name = "${var.image-name}"
  flavor_name = "${var.image-flavor}"
  key_pair = "${var.key-pair}"
  security_groups = ["${openstack_compute_secgroup_v2.k8s-security.name}"]
  network {
    name = "${openstack_networking_network_v2.k8s-network.name}"
  }
}
