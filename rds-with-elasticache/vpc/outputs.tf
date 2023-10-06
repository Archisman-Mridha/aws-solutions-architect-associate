output "vpc_id" {
  value = aws_vpc.default.id
  description = "Id of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "Id of the public subnet"
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
  description = "Id of the private subnets"
}