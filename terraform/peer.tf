# Code to setup peer connecitons

############################  VPC Peering US-EAST-2 => US-EAST-1 ############################

data "aws_caller_identity" "edify_caller_id" {
  provider = aws
}

resource "aws_vpc_peering_connection" "east2_to_east1" {
  provider      = aws.ohio
  vpc_id        = aws_vpc.edify_vpc_midw.id
  peer_vpc_id   = aws_vpc.edify_vpc_east.id
  peer_owner_id = data.aws_caller_identity.edify_caller_id.account_id
  peer_region   = "us-east-1"
  auto_accept   = false

  tags = {
    "Name" = "EDIFY_USEAST2_USEAST1_PEER_REQUESTER"
  }
}

resource "aws_vpc_peering_connection_accepter" "east2_east1_accepter" {
  provider                  = aws
  vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_east1.id
  auto_accept               = true

  tags = {
    "Name" = "EDIFY_USEAST2_USEAST1_ACCEPTER"
  }
}

############################  VPC Peering US-EAST-2 => US-WEST-2 ############################

resource "aws_vpc_peering_connection" "east2_to_west2" {
  provider      = aws.ohio
  vpc_id        = aws_vpc.edify_vpc_midw.id
  peer_vpc_id   = aws_vpc.edify_vpc_west.id
  peer_owner_id = data.aws_caller_identity.edify_caller_id.account_id
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    "Name" = "EDIFY_USEAST2_USWEST2_PEER_REQUESTER"
  }
}

resource "aws_vpc_peering_connection_accepter" "east2_west2_accepter" {
  provider                  = aws.oregon
  vpc_peering_connection_id = aws_vpc_peering_connection.east2_to_west2.id
  auto_accept               = true

  tags = {
    "Name" = "EDIFY_USEAST2_USWEST2_ACCEPTER"
  }
}

############################  VPC Peering US-WEST-2 => US-EAST-1 ############################

resource "aws_vpc_peering_connection" "west2_to_east1" {
  provider      = aws.oregon
  vpc_id        = aws_vpc.edify_vpc_west.id
  peer_vpc_id   = aws_vpc.edify_vpc_east.id
  peer_owner_id = data.aws_caller_identity.edify_caller_id.account_id
  peer_region   = "us-east-1"
  auto_accept   = false

  tags = {
    "Name" = "EDIFY_USWEST2_USEAST1_PEER_REQUESTER"
  }
}

resource "aws_vpc_peering_connection_accepter" "west2_east1_accepter" {
  provider                  = aws
  vpc_peering_connection_id = aws_vpc_peering_connection.west2_to_east1.id
  auto_accept               = true

  tags = {
    "Name" = "EDIFY_USWEST2_USEAST1_ACCEPTER"
  }
}

