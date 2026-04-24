output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "main_route_table_id" {
  value = aws_vpc.this.main_route_table_id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}
