# Holds the resources for the VPCs

############################  VPC for US-EAST-1 (Virginia) ############################

# VPC resource
resource "aws_vpc" "edify_vpc_east" {
  provider                         = aws
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = var.vpc_east1_cidr_block
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = false
  enable_dns_support               = true
  instance_tenancy                 = var.vpc_east1_tenancy
  tags                             = {
    "Name" = "EDIFY_VPC_EAST"
  }
}

# Internet gateway resource
resource "aws_internet_gateway" "edify_useast1_igw" {
  provider = aws
  tags     = {
    "Name" = "EDIFY_IGW_USEAST1"
  }
  vpc_id   = aws_vpc.edify_vpc_east.id
}

# Route table resource
resource "aws_route_table" "edify_useast1_rtb" {
  provider = aws
  propagating_vgws = []
  route            = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = aws_internet_gateway.edify_useast1_igw.id
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = ""
    },
    {
      cidr_block                = "10.2.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_east1.id
    },
    {
      cidr_block                = "10.1.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.west2_to_east1.id
    },
  ]
  tags             = {
    "Name" = "EDIFY_USEAST1_RTB"
  }
  vpc_id   = aws_vpc.edify_vpc_east.id
}

# Public subnet resource
resource "aws_subnet" "edify_10_0_0_0_useast1b_pub" {
  provider = aws
  assign_ipv6_address_on_creation = false
  availability_zone               = var.vpc_east1_snpub_avail_zone
  cidr_block                      = var.vpc_east1_snpub_cidr_block
  map_public_ip_on_launch         = false
  tags                            = {
    "Name" = "EDIFY_10.0.0.0_USEAST_1B_PUB"
  }
  vpc_id                          = aws_vpc.edify_vpc_east.id
  timeouts {}

  depends_on = [aws_internet_gateway.edify_useast1_igw]
}

# ACL resource that gets attached to the public subnet
resource "aws_network_acl" "edify_useast1_pub_acl" {
  provider = aws
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  subnet_ids      = [
    aws_subnet.edify_10_0_0_0_useast1b_pub.id
  ]
  tags            = {
    "Name" = "EDIFY_USEAST1_PUB_ACL"
  }
  vpc_id          = aws_vpc.edify_vpc_east.id
}

# Security group that only allows SSH access on port 60322
resource "aws_security_group" "edify_useast1_ssh_sg" {
  provider = aws
  description = "Allows SSH Access for Developers"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      self             = false
      security_groups  = []
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "SSH Custom Port"
      from_port        = var.vpc_east1_ssh_port
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = var.vpc_east1_ssh_port
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "Allow ICMP"
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  name        = "EDIFY_USEAST1_SSH_SG"
  tags        = {
    "NAME" = "EDIFY_USEAST1_SSH_SG"
  }
  timeouts {}
  vpc_id      = aws_vpc.edify_vpc_east.id
}

# Resource to associate the route table to the public subnet
resource "aws_route_table_association" "edify_useast1_pub_assoc" {
  subnet_id      = aws_subnet.edify_10_0_0_0_useast1b_pub.id
  route_table_id = aws_route_table.edify_useast1_rtb.id
}

############################  VPC for US-WEST-2 (Oregon) ############################

# VPC resource
resource "aws_vpc" "edify_vpc_west" {
  provider                         = aws.oregon
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = var.vpc_west2_cidr_block
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = false
  enable_dns_support               = true
  instance_tenancy                 = var.vpc_west2_tenancy
  tags                             = {
    "Name" = "EDIFY_VPC_WEST"
  }
}

# Internet gateway resource
resource "aws_internet_gateway" "edify_uswest2_igw" {
  provider = aws.oregon
  tags     = {
    "Name" = "EDIFY_IGW_USWEST2"
  }
  vpc_id   = aws_vpc.edify_vpc_west.id
}

# Route table resource
resource "aws_route_table" "edify_uswest2_rtb" {
  provider = aws.oregon
  propagating_vgws = []
  route            = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = aws_internet_gateway.edify_uswest2_igw.id
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = ""
    },
    {
      cidr_block                = "10.2.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_west2.id
    },
    {
      cidr_block                = "10.0.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.west2_to_east1.id
    },
  ]
  tags             = {
    "Name" = "EDIFY_USWEST2_RTB"
  }
  vpc_id   = aws_vpc.edify_vpc_west.id
}

# Public subnet resource
resource "aws_subnet" "edify_10_1_0_0_uswest2b_pub" {
  provider = aws.oregon
  assign_ipv6_address_on_creation = false
  availability_zone               = var.vpc_west2_snpub_avail_zone
  cidr_block                      = var.vpc_west2_snpub_cidr_block
  map_public_ip_on_launch         = false
  tags                            = {
    "Name" = "EDIFY_10.1.0.0_USWEST_2B_PUB"
  }
  vpc_id                          = aws_vpc.edify_vpc_west.id
  timeouts {}

  depends_on = [aws_internet_gateway.edify_uswest2_igw]
}

# ACL resource that gets attached to the public subnet
resource "aws_network_acl" "edify_uswest2_pub_acl" {
  provider = aws.oregon
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  subnet_ids      = [
    aws_subnet.edify_10_1_0_0_uswest2b_pub.id
  ]
  tags                            = {
    "Name" = "EDIFY_USWEST2_PUB_ACL"
  }
  vpc_id          = aws_vpc.edify_vpc_west.id
}

# Security group that only allows SSH access on port 60422
resource "aws_security_group" "edify_uswest2_ssh_sg" {
  provider = aws.oregon
  description = "Allows SSH/Ping Access for Developers"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      self             = false
      security_groups  = []
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "SSH Custom Port"
      from_port        = var.vpc_west2_ssh_port
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = var.vpc_west2_ssh_port
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "Allow ICMP"
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  name        = "EDIFY_USWEST2_SSH_SG"
  tags        = {
    "NAME" = "EDIFY_USWEST2_SSH_SG"
  }
  timeouts {}
  vpc_id      = aws_vpc.edify_vpc_west.id
}

# Resource to associate the route table to the public subnet
resource "aws_route_table_association" "edify_uswest2_pub_assoc" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.edify_10_1_0_0_uswest2b_pub.id
  route_table_id = aws_route_table.edify_uswest2_rtb.id
}

############################  VPC for US-EAST-2 (Ohio) ############################

# VPC resource
resource "aws_vpc" "edify_vpc_midw" {
  provider                         = aws.ohio
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = var.vpc_east2_cidr_block
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = false
  enable_dns_support               = true
  instance_tenancy                 = var.vpc_east2_tenancy
  tags                             = {
    "Name" = "EDIFY_VPC_MIDW"
  }
}

# Internet gateway resource
resource "aws_internet_gateway" "edify_useast2_igw" {
  provider = aws.ohio
  tags     = {
    "Name" = "EDIFY_IGW_USEAST2"
  }
  vpc_id   = aws_vpc.edify_vpc_midw.id
}

# Route table resource
resource "aws_route_table" "edify_useast2_rtb" {
  provider = aws.ohio
  propagating_vgws = []
  route            = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = aws_internet_gateway.edify_useast2_igw.id
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = ""
    },
    {
      cidr_block                = "10.0.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_east1.id
    },
    {
      cidr_block                = "10.1.0.0/24"
      egress_only_gateway_id    = ""
      gateway_id                = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      local_gateway_id          = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_endpoint_id           = ""
      vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_west2.id
    },
  ]
  tags             = {
    "Name" = "EDIFY_USEAST2_RTB"
  }
  vpc_id   = aws_vpc.edify_vpc_midw.id
}

# Public subnet resource
resource "aws_subnet" "edify_10_2_0_0_useast2b_pub" {
  provider = aws.ohio
  assign_ipv6_address_on_creation = false
  availability_zone               = var.vpc_east2_snpub_avail_zone
  cidr_block                      = var.vpc_east2_snpub_cidr_block
  map_public_ip_on_launch         = false
  tags                            = {
    "Name" = "EDIFY_10.2.0.0_USEAST_2B_PUB"
  }
  vpc_id                          = aws_vpc.edify_vpc_midw.id
  timeouts {}

  depends_on = [aws_internet_gateway.edify_useast2_igw]
}

# ACL resource that gets attached to the public subnet
resource "aws_network_acl" "edify_useast2_pub_acl" {
  provider = aws.ohio
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  subnet_ids      = [
    aws_subnet.edify_10_2_0_0_useast2b_pub.id
  ]
  tags            = {
    "Name" = "EDIFY_USEAST2_PUB_ACL"
  }
  vpc_id          = aws_vpc.edify_vpc_midw.id
}

# Security group that only allows SSH access on port 60322
resource "aws_security_group" "edify_useast2_ssh_sg" {
  provider = aws.ohio
  description = "Allows SSH Access for Developers"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      self             = false
      security_groups  = []
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "SSH Custom Port"
      from_port        = var.vpc_east2_ssh_port
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = var.vpc_east2_ssh_port
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = "Allow ICMP"
      from_port        = 8
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  name        = "EDIFY_USEAST2_SSH_SG"
  tags        = {
    "NAME" = "EDIFY_USEAST2_SSH_SG"
  }
  timeouts {}
  vpc_id      = aws_vpc.edify_vpc_midw.id
}

# Resource to associate the route table to the public subnet
resource "aws_route_table_association" "edify_useast2_pub_assoc" {
  provider       = aws.ohio
  subnet_id      = aws_subnet.edify_10_2_0_0_useast2b_pub.id
  route_table_id = aws_route_table.edify_useast2_rtb.id
}
