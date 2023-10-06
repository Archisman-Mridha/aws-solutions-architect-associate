resource "aws_security_group" "default" {
  vpc_id = var.vpc_id

  // Allow all incoming and outgoing traffic on port 6379 (Communication is limited to within the
  // VPC).
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}