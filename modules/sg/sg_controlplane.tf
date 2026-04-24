# -----------------------------
# Security Group for Control Plane
# -----------------------------
resource "aws_security_group" "tf_controlplane_sg" {
  name        = "tf-controlplane-sg"
  description = "Control Plane Security Group"
  vpc_id      = var.vpc_id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # K8s API (6443)
  ingress {
    description = "K8s API"
    from_port   = 6443  # Kubernetes API Server default port
    to_port     = 6443
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

  # etcd (2379-2380)
  ingress {
    description = "etcd"
    from_port   = 2379  # etcd default port
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10257
    to_port     = 10259
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
    Name = "public-controlplane-ec2-sg"
    Environment = var.environment
  }
}
