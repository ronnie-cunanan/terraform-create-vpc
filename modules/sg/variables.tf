variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}
