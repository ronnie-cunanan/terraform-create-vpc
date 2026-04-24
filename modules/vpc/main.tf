resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "tf-vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "tf-igw"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "tf-public-subnet-${var.environment}"
    Environment = var.environment
  }
}

# Tag the main route table
resource "aws_ec2_tag" "main_rt_tag" {
  resource_id = aws_vpc.this.main_route_table_id
  key         = "Name"
  value       = "tf-public-rt"
}

# Add IGW route to the main route table
resource "aws_route" "main_to_igw" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate public subnet to the main route table
resource "aws_route_table_association" "public_to_main" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_vpc.this.main_route_table_id
}
