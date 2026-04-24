# -----------------------------
# Security Group for Nodes
# -----------------------------
resource "aws_security_group" "tf_node_sg" {
  name        = "tf-node-sg"
  description = "Node Security Group"
  vpc_id      = var.vpc_id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubelet API (10250)
  ingress {
    description = "Kubelet API"
    from_port   = 10250  # Kubelet API default port
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NodePort (30000-32767)
  ingress {
    description = "NodePort services"
    from_port   = 30000   # NodePort services default range
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-node-ec2-sg"
    Environment = var.environment
  }
}
