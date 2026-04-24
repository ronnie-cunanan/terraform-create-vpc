output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "all_instance_public_ips" {
  description = "Public IPs of all instances created by ec2_instance module"
  value = {
    for instance_name, instance in module.ec2_instance : instance_name => instance.public_ip
  }
}
