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

# -------------------------
# IAM ROLES MODULE
# -------------------------
module "iam_roles" {
  source = "./modules/iam_roles" # perform creation of IAM roles and instance profiles

  environment = var.environment

  roles = {
    tf_ec2_role = {
      policies = [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      ]
    }

    tf_jenkins_role = {
      policies = [
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
        "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
        "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
        "arn:aws:iam::aws:policy/IAMFullAccess"        
      ]
    }
  }
}
