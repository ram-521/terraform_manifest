# Define the provider
provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Change this as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Create a private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a" # Change this as needed
  tags = {
    Name = "private-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-internet-gateway"
  }
}

# Create a route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Output the public subnet ID
output "public_subnet_id" {
  value = aws_subnet.public.id
}

# Output the private subnet ID
output "private_subnet_id" {
  value = aws_subnet.private.id
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}
