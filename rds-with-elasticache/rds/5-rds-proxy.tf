// Used for connection pooling.
resource "aws_db_proxy" "default" {
  name = "test"

  // The kinds of databases that the proxy can connect to. This value determines which database
  // network protocol the proxy recognizes when it interprets network traffic to and from the
  // database.
  engine_family = "POSTGRESQL"

  auth {
    // The RDS Proxy communicates with the RDS instance using username and password. These
    // credentials are stored in AWS Secrets Manager.
    auth_scheme = "SECRETS"
    // The ARN of the secret in AWS Secrets Manager which contains those credentials.
    secret_arn = aws_secretsmanager_secret.db_credentials.arn

    // Enforcing IAM authentication for database clients.
    iam_auth = "REQUIRED"
  }

  // The role which allows the RDS Proxy to access the secret containing those credentials, in AWS
  // Secrets Manager.
  role_arn = aws_iam_role.rds_proxy.arn

  vpc_subnet_ids = var.private_subnet_ids
  vpc_security_group_ids = [ aws_security_group.rds_proxy.id ]

  // Enforce TLS for database clients.
  require_tls = true
}

resource "aws_db_proxy_default_target_group" "default" {
  db_proxy_name = aws_db_proxy.default.name
}

resource "aws_db_proxy_target" "default" {
  db_proxy_name = aws_db_proxy.default.name
  target_group_name = aws_db_proxy_default_target_group.default.name

  db_instance_identifier = aws_db_instance.default.identifier
}