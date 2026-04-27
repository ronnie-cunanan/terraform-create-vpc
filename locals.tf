locals {
  sg_map = {
    "cicd-server"   = module.sg.security_group_ids[0]
    "control-plane" = module.sg.security_group_ids[1]
    "worker-node"   = module.sg.security_group_ids[2]
  }
}

locals {
  instance_profile_map = {
    "cicd-server"   = module.iam_roles.instance_profile_names["tf_jenkins_role"]
    "control-plane" = module.iam_roles.instance_profile_names["tf_ec2_role"]
    "worker-node"   = module.iam_roles.instance_profile_names["tf_ec2_role"]
  }
}
