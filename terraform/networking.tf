resource "openstack_networking_network_v2" "k8s-network" {
  name = "${var.cluster-name}-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "k8s-subnet" {
  name = "${var.cluster-name}-subnet"
  network_id = "${openstack_networking_network_v2.k8s-network.id}"
  cidr = "10.0.0.0/24"
  dns_nameservers = ["8.8.8.8"]
  enable_dhcp = "true"
  allocation_pools = {
   start = "10.0.0.100"
    end = "10.0.0.200"
  }
}

# Uncomment this if a router needs to be created
#resource "openstack_networking_router_v2" "k8s-router" {
#  name = "${var.cluster-name}-router"
#  external_gateway = "e25c3173-bb5c-4bbc-83a7-f0551099c8cd"
#}

resource "openstack_networking_router_interface_v2" "k8s-interface" {
  # Swap with this the below line if you uncommented the router above
  router_id = "${var.ext-router-id}"
  #router_id = "${openstack_networking_router_v2.k8s-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.k8s-subnet.id}"
}
