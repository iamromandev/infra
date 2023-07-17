terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.8"
    }
  }
  required_version = "~> 1.5"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  zones = ["${var.aws_region}a", "${var.aws_region}b"]
}

# vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.environment
    Name        = "${var.project}-vpc-${var.environment}"
  }
}

# public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(local.zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Environment = var.environment
    Name        = "${var.project}-public-subnet-${element(local.zones, count.index)}-${var.environment}"
  }
}

# private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(local.zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Environment = var.environment
    Name        = "${var.project}-private-subnet-${element(local.zones, count.index)}-${var.environment}"
  }
}

# internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Environment = var.environment
    Name        = "${var.project}-ig-${var.environment}"
  }
}

# elastic ip for nat
/*resource "aws_eip" "nat_eip" {
  count = length(local.zones)

  domain     = "vpc"
  depends_on = [aws_internet_gateway.ig]
}*/

# nat gateway
/*resource "aws_nat_gateway" "ng" {
  count = length(local.zones)

  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = {
    Environment = var.environment
    Name        = "${var.project}-ng-${element(local.zones, count.index)}-${var.environment}"
  }
}*/

# public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Environment = var.environment
    Name        = "${var.project}-public-route-table-${var.environment}"
  }
}

# private route table
/*resource "aws_route_table" "private" {
  count = length(aws_nat_gateway.ng)

  vpc_id = aws_vpc.vpc.id
  tags   = {
    Environment = var.environment
    Name        = "${var.project}-private-route-table-${var.environment}"
  }
}*/

# route for internet gateway
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
}

# route for nat gateway
/*resource "aws_route" "private" {
  count = length(aws_route_table.private)

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  gateway_id             = element(aws_nat_gateway.ng.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
}*/

# route table association for public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

# route table association for private subnets
# TODO


