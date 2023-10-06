resource "aws_secretsmanager_secret" "db_credentials" {
  name = "test-db-master-user-credentials"
  description = "Credentials for the master user of test RDS DB"

  recovery_window_in_days = 0 // Disable secret recovery
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  secret_string = jsonencode({
    username = local.db_master_user_name
    password = local.db_master_user_password
  })
}