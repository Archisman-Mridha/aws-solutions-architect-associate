resource "aws_subnet" "private_subnets" {
  count = local.private_subnet_count

  vpc_id = aws_vpc.default.id

  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, local.total_subnet_count, 1 + count.index)

  map_public_ip_on_launch = false
}

resource "aws_route_table" "private_subnet_route_tables" {
  count = local.private_subnet_count
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table_association" "private_subnet_route_table_associations" {
  count = local.private_subnet_count

  route_table_id = aws_route_table.private_subnet_route_tables[count.index].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}