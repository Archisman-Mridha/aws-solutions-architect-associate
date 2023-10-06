output "rds_proxy_endpoint" {
  value = aws_db_proxy.default.endpoint
  description = "Endpoint to connect to the RDS proxy"
}