#------------------------------------------------------
## Setup nodes for Satellite
#------------------------------------------------------
#
# subnet naming convention
# 1a - zone 1 public
# 1b - zone 1 private
# 2a - zone 2 public
# 2b - zone 2 private
# 3a - zone 3 public
# 3b - zone 3 private
#
#------------------------------------------------------


#------------------------------------------------------
## Select resource group
#------------------------------------------------------
data "ibm_resource_group" "default_resource_group" {
  name = var.resource_group
}

#------------------------------------------------------
## Select RHEL 7, pre-req for Satellite
#------------------------------------------------------
data "ibm_is_image" "image" {
  name = "ibm-redhat-7-0-64-minimal-for-vsi"
}


#------------------------------------------------------
## Create VPC address prefixes for AZ1 public and private
#------------------------------------------------------
# AZ 1 address prefixes
resource "ibm_is_vpc_address_prefix" "prefix1a" {
  name = "${var.root_name}-addr-prefix1a"
  zone   = "${var.default_az}-1"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[0]}/24"
}

resource "ibm_is_vpc_address_prefix" "prefix1b" {
  name = "${var.root_name}-addr-prefix1b"
  zone   = "${var.default_az}-1"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[1]}/24"
}

#------------------------------------------------------
## Create VPC address prefixes for AZ2 public and private
#------------------------------------------------------
resource "ibm_is_vpc_address_prefix" "prefix2a" {
  name = "${var.root_name}-addr-prefix2a"
  zone   = "${var.default_az}-2"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[2]}/24"
}

resource "ibm_is_vpc_address_prefix" "prefix2b" {
  name = "${var.root_name}-addr-prefix2b"
  zone   = "${var.default_az}-2"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[3]}/24"
}

#------------------------------------------------------
## Create VPC address prefixes for AZ3 public and private
#------------------------------------------------------
resource "ibm_is_vpc_address_prefix" "prefix3a" {
  name = "${var.root_name}-addr-prefix3a"
  zone   = "${var.default_az}-3"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[4]}/24"
}

resource "ibm_is_vpc_address_prefix" "prefix3b" {
  name = "${var.root_name}-addr-prefix3b"
  zone   = "${var.default_az}-3"
  vpc         = ibm_is_vpc.vpc.id
  cidr        = "${var.prefixes[5]}/24"
}

#------------------------------------------------------
## Create VPC
#------------------------------------------------------
resource "ibm_is_vpc" "vpc" {
    name                      = "${var.root_name}-vpc"
    resource_group            = data.ibm_resource_group.default_resource_group.id
    tags                      = var.default_tags
    address_prefix_management = "manual"
}

#------------------------------------------------------
## Create public gateway for AZ1
#------------------------------------------------------
resource "ibm_is_public_gateway" "gateway1" {
    name             = "${var.root_name}-zone1-pgw"
    vpc              = ibm_is_vpc.vpc.id
    zone             = "${var.default_az}-1"
    tags             = var.default_tags
}

#------------------------------------------------------
## Create a subnet in AZ1 with a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet1a" {
    name                     = "${var.root_name}-zone1-public-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-1"
    ipv4_cidr_block          = "${var.prefixes[0]}/24"
    public_gateway           = ibm_is_public_gateway.gateway1.id
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix1a]
}

#------------------------------------------------------
## Create a subnet in AZ1 without a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet1b" {
    name                     = "${var.root_name}-zone1-private-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-1"
    ipv4_cidr_block          = "${var.prefixes[1]}/24"
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix1b]
}

#------------------------------------------------------
## Create public gateway for AZ2
#------------------------------------------------------
resource "ibm_is_public_gateway" "gateway2" {
    name             = "${var.root_name}-zone2-pgw"
    vpc              = ibm_is_vpc.vpc.id
    zone             = "${var.default_az}-2"
    tags             = var.default_tags
}

#------------------------------------------------------
## Create a subnet in AZ2 with a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet2a" {
    name                     = "${var.root_name}-zone2-public-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-2"
    ipv4_cidr_block          = "${var.prefixes[2]}/24"
    public_gateway           = ibm_is_public_gateway.gateway2.id
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix2a]
}

#------------------------------------------------------
## Create a subnet in AZ2 without a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet2b" {
    name                     = "${var.root_name}-zone2-private-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-2"
    ipv4_cidr_block          = "${var.prefixes[3]}/24"
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix2b]
}

#------------------------------------------------------
## Create public gateway for AZ3
#------------------------------------------------------
resource "ibm_is_public_gateway" "gateway3" {
    name             = "${var.root_name}-zone3-pgw"
    vpc              = ibm_is_vpc.vpc.id
    zone             = "${var.default_az}-3"
    tags             = var.default_tags
}

#------------------------------------------------------
## Create a subnet in AZ3 with a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet3a" {
    name                     = "${var.root_name}-zone3-public-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-3"
    ipv4_cidr_block          = "${var.prefixes[4]}/24"
    public_gateway           = ibm_is_public_gateway.gateway3.id
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix3a]
}

#------------------------------------------------------
## Create a subnet in AZ3 without a pgw
#------------------------------------------------------
resource "ibm_is_subnet" "subnet3b" {
    name                     = "${var.root_name}-zone3-private-subnet"
    vpc                      = ibm_is_vpc.vpc.id
    zone                     = "${var.default_az}-3"
    ipv4_cidr_block          = "${var.prefixes[5]}/24"
    resource_group           = data.ibm_resource_group.default_resource_group.id
    depends_on = [ibm_is_vpc_address_prefix.prefix3b]
}

#------------------------------------------------------
## Create default security group
#------------------------------------------------------
resource "ibm_is_security_group_rule" "security_group_rule_tcp" {
    group = ibm_is_vpc.vpc.default_security_group
    direction = "inbound"
    tcp {
        port_min = 30000
        port_max = 32767
    }
 }

 resource "ibm_is_security_group_rule" "security_group_rule_icmp" {
    group = ibm_is_vpc.vpc.default_security_group
    direction = "inbound"
    remote = "0.0.0.0/0"
    icmp {
        code = 20
        type = 30
    }
 }

 resource "ibm_is_security_group_rule" "security_group_rule_ssh" {
    group = ibm_is_vpc.vpc.default_security_group
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp {
        port_min = 22
        port_max = 22
    }
 }

 resource "ibm_is_security_group_rule" "security_group_rule_http" {
    group = ibm_is_vpc.vpc.default_security_group
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp {
        port_min = 80
        port_max = 80
    }
 }


 resource "ibm_is_security_group_rule" "security_group_rule_https" {
    group = ibm_is_vpc.vpc.default_security_group
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp {
        port_min = 443
        port_max = 443
    }
 }


#------------------------------------------------------
## Create SSH key variable
#------------------------------------------------------
variable "ssh_key" {
}

data "ibm_is_ssh_key" "ssh_key_id" {
  name = var.ssh_key
}

#------------------------------------------------------
## Create Control Host VSI(s) in subnet1a
#------------------------------------------------------
resource "ibm_is_instance" "zone1_cluster" {
  count       = var.per_zone_control_host_count
  name        = "${var.root_name}-control-zone1-${count.index}"
  image       = data.ibm_is_image.image.id
  profile     = var.control_host_profile

  primary_network_interface {
    subnet    = ibm_is_subnet.subnet1a.id
  }

  vpc        = ibm_is_vpc.vpc.id
  zone       = "${var.default_az}-1"
  keys       = [data.ibm_is_ssh_key.ssh_key_id.id]
  tags       = var.default_tags

}

resource "ibm_is_floating_ip" "control_fip1" {
  count  = var.per_zone_control_host_count
  name   = "${var.root_name}-control-fip1-${count.index}"
  target = ibm_is_instance.zone1_cluster[count.index].primary_network_interface.0.id
}

#------------------------------------------------------
## Create Control Host VSI(s) in subnet2a
#------------------------------------------------------
resource "ibm_is_instance" "zone2_cluster" {
  count       = var.per_zone_control_host_count
  name        = "${var.root_name}-control-zone2-${count.index}"
  image       = data.ibm_is_image.image.id
  profile     = var.control_host_profile

  primary_network_interface {
    subnet    = ibm_is_subnet.subnet2a.id
  }

  vpc        = ibm_is_vpc.vpc.id
  zone       = "${var.default_az}-2"
  keys       = [data.ibm_is_ssh_key.ssh_key_id.id]
  tags       = var.default_tags
}

resource "ibm_is_floating_ip" "control_fip2" {
  count  = var.per_zone_control_host_count
  name   = "${var.root_name}-control-fip2-${count.index}"
  target = ibm_is_instance.zone2_cluster[count.index].primary_network_interface.0.id
}

#------------------------------------------------------
## Create Control Host VSI(s) in subnet3a
#------------------------------------------------------
resource "ibm_is_instance" "zone3_cluster" {
  count       = var.per_zone_control_host_count
  name        = "${var.root_name}-control-zone3-${count.index}"
  image       = data.ibm_is_image.image.id
  profile     = var.control_host_profile

  primary_network_interface {
    subnet    = ibm_is_subnet.subnet3a.id
  }

  vpc        = ibm_is_vpc.vpc.id
  zone       = "${var.default_az}-3"
  keys       = [data.ibm_is_ssh_key.ssh_key_id.id]
  tags       = var.default_tags
}

resource "ibm_is_floating_ip" "control_fip3" {
  count  = var.per_zone_control_host_count
  name   = "${var.root_name}-control-fip3-${count.index}"
  target = ibm_is_instance.zone3_cluster[count.index].primary_network_interface.0.id
}


#------------------------------------------------------
## Create Worker Host VSI(s) in subnet1a
#------------------------------------------------------
resource "ibm_is_instance" "zone1_worker_cluster" {
  count       = var.per_zone_worker_count
  name        = "${var.root_name}-worker-zone1-${count.index}"
  image       = data.ibm_is_image.image.id
  profile     = var.worker_host_profile

  primary_network_interface {
    subnet    = ibm_is_subnet.subnet1a.id
  }

  vpc        = ibm_is_vpc.vpc.id
  zone       = "${var.default_az}-1"
  keys       = [data.ibm_is_ssh_key.ssh_key_id.id]
  tags       = var.default_tags
}

resource "ibm_is_floating_ip" "worker_fip1" {
  count  = var.per_zone_worker_count
  name   = "${var.root_name}-worker-fip1-${count.index}"
  target = ibm_is_instance.zone1_worker_cluster[count.index].primary_network_interface.0.id
}


#------------------------------------------------------
## Create inventory file, for use with ansible
#------------------------------------------------------
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
  {
    zone1_control_ips = ibm_is_floating_ip.control_fip1[*].address
    zone2_control_ips = ibm_is_floating_ip.control_fip2[*].address
    zone3_control_ips = ibm_is_floating_ip.control_fip3[*].address
  }
  )
  filename = "satellite_control_hosts"
}

resource "local_file" "AnsibleInventory2" {
  content = templatefile("inventory2.tmpl",
  {
    zone1_worker_ips = ibm_is_floating_ip.worker_fip1[*].address
  }
  )
  filename = "satellite_worker_hosts"
}
