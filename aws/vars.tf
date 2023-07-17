variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.128.0/20"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.16.0/20", "10.0.144.0/20"]
  description = "CIDR block for Private Subnet"
}