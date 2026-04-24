module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "tf_vpc"
  cidr = var.vpc_cidr

  azs = [var.az]

  public_subnets = [var.public_subnet_cidr]

  enable_dns_hostnames = true
  enable_dns_support   = true
  create_igw           = true
  enable_nat_gateway   = false

  # Allow us to modify the main route table
  manage_default_route_table       = true

  # Tag the IGW
  igw_tags = {
    Name = "tf-igw-${var.environment}"
  }  

  public_subnet_tags = {
    Name        = "tf-public-subnet-${var.environment}"
    Environment = var.environment
  }

  tags = {
    Environment = var.environment
  }
}

locals {
  public_subnet_map = {
    for idx, subnet_id in module.vpc.public_subnets :
    idx => subnet_id
  }
}

resource "aws_route_table_association" "public_to_main" {
  for_each = local.public_subnet_map

  subnet_id      = each.value
  route_table_id = module.vpc.vpc_main_route_table_id
}

resource "aws_route" "main_to_igw" {
  route_table_id         = module.vpc.vpc_main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.igw_id
}

resource "aws_ec2_tag" "main_rt_tag" {
  resource_id = module.vpc.vpc_main_route_table_id
  key         = "Name"
  value       = "tf-public-rt-${var.environment}"
}
