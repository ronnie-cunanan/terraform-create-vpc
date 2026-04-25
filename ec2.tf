module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["cicd-server", "control-plane", "worker-node"])

  name = "tf-${each.key}"

  instance_type = "t3.micro"
  key_name      = var.key_name
  monitoring    = true
  subnet_id     = module.vpc.public_subnet_id

  create_security_group = false
  
  vpc_security_group_ids = [
    local.sg_map[each.key]
  ]

  root_block_device = {
    volume_type           = "gp3"
    volume_size           = each.key == "worker-node" ? 80 : 40
    delete_on_termination = true
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}