locals {
  sg_map = {
    "cicd-server"   = module.sg.security_group_ids[0]
    "control-plane" = module.sg.security_group_ids[1]
    "worker-node"   = module.sg.security_group_ids[2]
  }
}
