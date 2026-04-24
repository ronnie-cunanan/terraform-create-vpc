resource "aws_route_table" "tf_public_rt" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "tf-public-rt-${var.environment}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.tf_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.igw_id
}
