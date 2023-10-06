resource "aws_elasticache_subnet_group" "default" {
  name = "test"

  subnet_ids = var.private_subnet_ids
}