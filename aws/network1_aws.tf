# VPC1
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC1"
  }
}

#---------- Networking for VPC1-------------

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IG1"
  }
}

# Public Subnet VPC1 - For Jumphost
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.subnet_availability_zone # Specify your availability zone

  tags = {
    Name = "Public-Subnet"
  }
}

# Prod Subnet - private subnet
resource "aws_subnet" "prod_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.subnet_availability_zone

  tags = {
    Name = "Prod-Subnet"
  }
}

# Dev Subnet - private subnet
resource "aws_subnet" "dev_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.subnet_availability_zone

  tags = {
    Name = "Dev-Subnet"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "Public-Route-Table"
  }
}

# Associate Public Subnet with the Route Table
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create a Route for Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Create a Route for Staging peering
resource "aws_route" "public_to_staging_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "10.10.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1-to-vpc2-peering.id
}

# Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "NAT-Gateway"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "Private-Route-Table"
  }
}

# Create a Route for the NAT Gateway in the Private Route Table
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Create a Route for Staging peering in the Private Route tab;e
resource "aws_route" "private_to_staging_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "10.10.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1-to-vpc2-peering.id
}

# Associate Private Subnet with the Private Route Table
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Associate Private Subnet with the Private Route Table
resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.private_rt.id
}