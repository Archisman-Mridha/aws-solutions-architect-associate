// Group of private subnets dedicated to DB instances.
resource "aws_db_subnet_group" "default" {
  subnet_ids = var.private_subnet_ids
}