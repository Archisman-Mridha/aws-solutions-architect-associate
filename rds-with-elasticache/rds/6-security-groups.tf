resource "aws_security_group" "rds_instance" {
  vpc_id = var.vpc_id

  // Only the RDS proxy can access the RDS instance.
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [ aws_security_group.rds_proxy.id ]
  }
}

resource "aws_security_group" "rds_proxy" {
  vpc_id = var.vpc_id

  // Allow all incoming and outgoing traffic on port 5432 (Communication is limited to within the
  // VPC since the RDS proxy is never accessibly publicly).
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}