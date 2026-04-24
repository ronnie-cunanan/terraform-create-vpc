output "cicd_sg_id" {
  value = aws_security_group.tf_cicd_sg.id
}

output "security_group_ids" {
  description = "List of all security group IDs in the sg module"
  value = [
    aws_security_group.tf_cicd_sg.id,
    aws_security_group.tf_controlplane_sg.id,
    aws_security_group.tf_node_sg.id
  ]
}