terraform {
  required_version = ">= 0.12"
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "vpc_demo" {
 cidr_block = "10.0.0.0/16"
 enable_dns_hostnames = true
 enable_dns_support =  true
 tags = {
    Name = "demo-vpc"
  }
}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_demo.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc_demo.id 
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "private-subnet"
    }
}
resource "aws_internet_gateway" "igw-public" {
    vpc_id = aws_vpc.vpc_demo.id 
    tags = {
      Name = "vpc_demo-internet-gateway"
    }
}
resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.vpc_demo.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-public.id
        
    }
    tags = {
    Name = "public-route-table"
  }
  
}
