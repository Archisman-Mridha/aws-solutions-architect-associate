resource "aws_iam_role" "rds_proxy" {
  name = "test-rds-proxy"
  path = "/aws-solutions-architect-associate/rds-with-elasticache/"

  // IAM policy that grants an entity permission to assume this IAM role.
  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "rds.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

// The IAM policy which grants access of the secret in the AWS Secrets Manager, to the RDS Proxy.
resource "aws_iam_role_policy" "rds_proxy" {
  role = aws_iam_role.rds_proxy.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "secretsmanager:GetSecretValue"
        Resource = [ aws_secretsmanager_secret.db_credentials.arn ]
      }
    ]
  })
}