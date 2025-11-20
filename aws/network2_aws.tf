# VPC1
resource "aws_vpc" "vpc2" {
  cidr_block = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC2"
  }
}

# Staging Subnet VPC2 - For Staging
resource "aws_subnet" "staging_subnet" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.10.4.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a" # Specify your availability zone

  tags = {
    Name = "Staging-Subnet"
  }
}

#Peer VPC2
resource "aws_vpc_peering_connection" "vpc1-to-vpc2-peering" {
  peer_vpc_id   = aws_vpc.vpc2.id
  vpc_id        = aws_vpc.vpc1.id
  auto_accept = true

  tags = {
    Name = "VPC1-to-VPC2-Peering"
  }
}

# Staging Route Table
resource "aws_route_table" "staging_rt" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "VPC2-Staging-Route-Table"
  }
}

# Associate Staging Subnet with the Route Table
resource "aws_route_table_association" "staging_association" {
  subnet_id      = aws_subnet.staging_subnet.id
  route_table_id = aws_route_table.staging_rt.id
}

# Create a Route for VPC peering
resource "aws_route" "vpc2_vpc1_route" {
  route_table_id         = aws_route_table.staging_rt.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1-to-vpc2-peering.id
}