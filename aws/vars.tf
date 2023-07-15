variable "environment" {
  default = "dev"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(any)
  default = ["10.0.0.0/20", "10.0.128.0/20"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnet_cidrs" {
  type = list(any)
  default = ["10.0.16.0/20", "10.0.144.0/20"]
  description = "CIDR block for Private Subnet"
}