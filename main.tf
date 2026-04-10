module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-southeast-2a"]

  public_subnets = ["10.0.0.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  enable_vpn_gateway = false

  public_subnet_tags = {
    Name = "public-subnet"
  }

  tags = {
    Environment = "dev"
  }
}
