resource "openstack_compute_secgroup_v2" "k8s-security" {
  name = "${var.cluster-name}-security"
  description = "a security group for kubernetes"
  # This is opens SSH to the world! Take care and narrow this CIDR down to from wherever you're connecting if possible.
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 6443
    to_port = 6443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 1 
    to_port = 65535
    ip_protocol = "tcp"
    self = "true"
  }
  rule {
    from_port = 1 
    to_port = 65535
    ip_protocol = "udp"
    self = "true"
  }
}
