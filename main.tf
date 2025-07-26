resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.tags, {
    name = "${var.vpc_name} - First VPC"
  })
}

resource "aws_vpc" "second" {
  cidr_block           = var.second_vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.tags, {
    name = "${var.vpc_name} - Second VPC"
  })
}

resource "aws_security_group" "TF-SG-01" {
  name        = var.aws_security_group
  description = "Allow SSH for EC2 Instances"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "SSH-Access" {

  security_group_id = aws_security_group.TF-SG-01.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  ip_protocol       = "tcp"
  to_port           = var.SSH_Port
  from_port         = var.SSH_Port 
}

resource "aws_vpc_security_group_egress_rule" "Allow-All-outbound" {
  security_group_id = aws_security_group.TF-SG-01.id
  cidr_ipv4         = var.Allow_All
  ip_protocol       = var.All_Outbound_Ports
}

resource "aws_instance" "test-vm-01" {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = merge(var.tags, {
    Name = "Test-VM-01"
  })
  
}


resource "aws_eip" "lb" {
  instance = aws_instance.test-vm-01.id
  domain   = "vpc"
  tags = {
    Name = "Test-Public-IP"
  }
}
