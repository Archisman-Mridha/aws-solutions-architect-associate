output "rds_proxy_endpoint" {
  value = module.rds.rds_proxy_endpoint
  description = "Endpoint to connect to the RDS proxy"
}