# Creates the EC2 instances in 3 regions, US-EAST-1 (Virginia), US-WEST-2 (Oregon), US-EAST-2 (Ohio)

############################  EC2 Instance for US-EAST-1 (Virginia) ############################

# Register our SSH key pair
resource "aws_key_pair" "edify_useast1_ssh_key_pair" {
  provider   = aws
  key_name   = "edify_useast1_rsa"
  public_key = var.ec2_ssh_public_key
}

resource "aws_instance" "edify_ec2_useast1_t2micro" {
  provider                      = aws
  ami                           = var.ec2_east1_ami_id
  associate_public_ip_address   = true
  availability_zone             = var.vpc_east1_snpub_avail_zone
  instance_type                 = "t2.micro"
  key_name                      = aws_key_pair.edify_useast1_ssh_key_pair.id
  private_ip                    = var.ec2_east1_private_ip
  root_block_device {
    delete_on_termination = true
  }
  subnet_id                     = aws_subnet.edify_10_0_0_0_useast1b_pub.id
  vpc_security_group_ids        = [
    aws_security_group.edify_useast1_ssh_sg.id
  ]
  tags                          = {
    "Name"                      = "EDIFY_EC2_USEAST1_T2MICRO"
  }
  depends_on = [aws_vpc.edify_vpc_east, aws_internet_gateway.edify_useast1_igw]
}

############################  EC2 Instance for US-WEST-2 (Oregon) ############################

# Register our SSH key pair
resource "aws_key_pair" "edify_uswest2_ssh_key_pair" {
  provider   = aws.oregon
  key_name   = "edify_uswest2_rsa"
  public_key = var.ec2_ssh_public_key
}

resource "aws_instance" "edify_ec2_uswest2_t2micro" {
  provider                      = aws.oregon
  ami                           = var.ec2_west2_ami_id
  associate_public_ip_address   = true
  availability_zone             = var.vpc_west2_snpub_avail_zone
  instance_type                 = "t2.micro"
  key_name                      = aws_key_pair.edify_uswest2_ssh_key_pair.id
  private_ip                    = var.ec2_west2_private_ip
  root_block_device {
    delete_on_termination = true
  }
  subnet_id                     = aws_subnet.edify_10_1_0_0_uswest2b_pub.id
  vpc_security_group_ids        = [
    aws_security_group.edify_uswest2_ssh_sg.id
  ]
  tags                          = {
    "Name"                      = "EDIFY_EC2_USWEST2_T2MICRO"
  }
  depends_on = [aws_vpc.edify_vpc_west, aws_internet_gateway.edify_uswest2_igw]
}

############################  EC2 Instance for US-EAST-2 (Ohio) ############################

# Register our SSH key pair
resource "aws_key_pair" "edify_useast2_ssh_key_pair" {
  provider   = aws.ohio
  key_name   = "edify_useast2_rsa"
  public_key = var.ec2_ssh_public_key
}

resource "aws_instance" "edify_ec2_useast2_t2micro" {
  provider                      = aws.ohio
  ami                           = var.ec2_east2_ami_id
  associate_public_ip_address   = true
  availability_zone             = var.vpc_east2_snpub_avail_zone
  instance_type                 = "t2.micro"
  key_name                      = aws_key_pair.edify_useast2_ssh_key_pair.id
  private_ip                    = var.ec2_east2_private_ip
  root_block_device {
    delete_on_termination = true
  }
  subnet_id                     = aws_subnet.edify_10_2_0_0_useast2b_pub.id
  vpc_security_group_ids        = [
    aws_security_group.edify_useast2_ssh_sg.id
  ]
  tags                          = {
    "Name"                      = "EDIFY_EC2_USEAST2_T2MICRO"
  }
  depends_on = [aws_vpc.edify_vpc_midw, aws_internet_gateway.edify_useast2_igw]
}
