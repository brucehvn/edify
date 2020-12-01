variable "ec2_ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzXZ0xjUhsvTi2Ul1Qwu8jV/PFkuIL8PwqmlaF5FMvRhdvTkidtsKDqc0arAxKSCJzWBBwFuy2qusO2WJTA95Fnb/kzVSfr+Er4eK0cjox4NWluIRK6F2mEU0G0EWfFW2vPXMt2gK0Fs1mEdWAPnPh/YARToWLc9SUWrdADTdLILQEaotZVeaOG1UYl5WH7m7j+ySQ6hDdMLWVCXHcEGkj6rhvqMZMXO7K1JOrfhONYGPFPrJdE2FdpZZv+LlvA62PWWSjeNkkcjnaoOUQalaP5CgdosmNHYYTcODFNycTHiWzGgE7hKrsb7cXKJ030Df7lWpc5e0gX/3P7Rjy72X3"
}
# US-EAST-1 Variables
variable "vpc_east1_snpub_avail_zone" {
  default = "us-east-1b"
}
variable "vpc_east1_tenancy" {
  default = "default"
}
variable "vpc_east1_snpub_cidr_block" {
  default = "10.0.0.0/24"
}
variable "vpc_east1_cidr_block" {
  default = "10.0.0.0/16"
}
variable "vpc_east1_ssh_port" {
  default = 22
}
variable "ec2_east1_private_ip" {
  default = "10.0.0.12"
}
variable "ec2_east1_ami_id" {
  default = "ami-04d29b6f966df1537"
}

# US-WEST-2 Variables
variable "vpc_west2_snpub_avail_zone" {
  default = "us-west-2b"
}
variable "vpc_west2_tenancy" {
  default = "default"
}
variable "vpc_west2_snpub_cidr_block" {
  default = "10.1.0.0/24"
}
variable "vpc_west2_cidr_block" {
  default = "10.1.0.0/16"
}
variable "vpc_west2_ssh_port" {
  default = 22
}
variable "ec2_west2_private_ip" {
  default = "10.1.0.12"
}
variable "ec2_west2_ami_id" {
  default = "ami-0e472933a1395e172"
}

# US-EAST-2 Variables
variable "vpc_east2_snpub_avail_zone" {
  default = "us-east-2b"
}
variable "vpc_east2_tenancy" {
  default = "default"
}
variable "vpc_east2_snpub_cidr_block" {
  default = "10.2.0.0/24"
}
variable "vpc_east2_cidr_block" {
  default = "10.2.0.0/16"
}
variable "vpc_east2_ssh_port" {
  default = 22
}
variable "ec2_east2_private_ip" {
  default = "10.2.0.12"
}
variable "ec2_east2_ami_id" {
  default = "ami-09558250a3419e7d0"
}

