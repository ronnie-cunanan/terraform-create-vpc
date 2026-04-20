module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "main-vpc"
  cidr = var.vpc_cidr

  azs = [var.az]

  public_subnets = [var.public_subnet_cidr]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  enable_vpn_gateway = false

  public_subnet_tags = {
    Name = "public-subnet-${var.environment}"
  }

  tags = {
    Environment = var.environment
  }
}
