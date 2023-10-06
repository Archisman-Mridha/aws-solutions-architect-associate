resource "aws_subnet" "public" {
  vpc_id = aws_vpc.default.id

  availability_zone = var.availability_zones[0]
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, local.total_subnet_count, 0)

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.default.id

  // All instances in a public subnet can access the internet gateway.
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  route_table_id = aws_route_table.public_subnet_route_table.id
  subnet_id      = aws_subnet.public.id
}