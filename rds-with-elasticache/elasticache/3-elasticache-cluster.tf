resource "aws_elasticache_cluster" "default" {
  apply_immediately = false

  cluster_id = "test"

  engine = "redis"
  engine_version = "6.2"

  auto_minor_version_upgrade = true

  node_type = "cache.t2.micro"
  num_cache_nodes = 1 // Initial number of cache nodes that the cache cluster will have.

  az_mode = "single-az"
  availability_zone = var.availability_zones[0]
  subnet_group_name = aws_elasticache_subnet_group.default.name
  security_group_ids = [ aws_security_group.default.id ]

  port = 6379
  ip_discovery = "ipv4"
  network_type = "ipv4"

  snapshot_retention_limit = 0
}