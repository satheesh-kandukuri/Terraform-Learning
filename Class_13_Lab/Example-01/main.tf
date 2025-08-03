# VPC Creation
resource "aws_vpc" "Jio-VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "JIO-VPC"
  }
}


# Public Subnet Creation
resource "aws_subnet" "Public-subnet-01" {
  vpc_id                  = aws_vpc.Jio-VPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-subnet-01"
  }
}

resource "aws_subnet" "Public-subnet-02" {
  vpc_id                  = aws_vpc.Jio-VPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public-subnet-02"
  }
}

# Create internet Gateway 

resource "aws_internet_gateway" "JIO-IGW" {
  vpc_id = aws_vpc.Jio-VPC.id

  tags = {
    Name = "Internet-Gway"
  }
}

# route table creation

resource "aws_route_table" "Public-Route-Table" {
  vpc_id = aws_vpc.Jio-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.JIO-IGW.id
  }
  tags = {
    Name = "Public-Route-Table"
  }
}


# EC2 instace creation with Public IP
resource "aws_instance" "test-01" {
  ami           = "ami-08a6efd148b1f7504"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.Public-subnet-01.id
  key_name      = "PractiseKeyPair"
  tags = {
    Name = "Public-VM-01"
  }
}

resource "aws_instance" "test-02" {
  ami           = "ami-08a6efd148b1f7504"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.Public-subnet-02.id
  key_name      = "PractiseKeyPair"
  tags = {
    Name = "Public-VM-02"
  }
}

