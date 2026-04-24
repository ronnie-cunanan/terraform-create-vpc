variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "environment" {
  type = string
}

variable "az" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}