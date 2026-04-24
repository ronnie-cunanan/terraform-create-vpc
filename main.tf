# -------------------------
# VPC MODULE
# -------------------------
module "vpc" {
  source  = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  az                  = var.az
  public_subnet_cidr  = var.public_subnet_cidr
  environment         = var.environment
}

# -------------------------
# SECURITY GROUP MODULE
# -------------------------
module "sg" {
  source = "./modules/sg"

  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}
