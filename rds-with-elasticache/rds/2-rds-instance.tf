resource "aws_db_instance" "default" {

  apply_immediately = false
  deletion_protection = false

  // Name of default database which will be created during the DB instance creation.
  db_name = "test"

  // Credentials for the master DB user.
  username = local.db_master_user_name
  password = local.db_master_user_password

  engine = "postgres"
  engine_version = "15.4"

  auto_minor_version_upgrade = true
  allow_major_version_upgrade = true

  storage_type = "gp2"       // Storage is backed by EBS.
  allocated_storage = 20     // Initial amount of allocated storage (in Gibibytes).
  max_allocated_storage = 20 // Maximum amount of storage the instance can scale to.

  // General-purpose instance classes powered by Arm-based AWS Graviton2 processors.
  instance_class = "db.t4g.micro"

  network_type = "IPV4"
  port = 5432
  publicly_accessible = false

  availability_zone = var.availability_zones[0]
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [ aws_security_group.rds_instance.id ]

  // Set this to true, if you want to have standby instances in different availability zones (for
  // Disaster Recovery).
  multi_az = false

  // Retentation period for automated backups (in days). It can't be disabled since the DB instance
  // is used as a source for a read replica.
  backup_retention_period = 1
  backup_target = "region"        // Where automated and manual backups are stored.
  delete_automated_backups = true // Delete automated backups when the DB instance is deleted.
  skip_final_snapshot = true      // Don't create a final snapshot before the instance is deleted.

  enabled_cloudwatch_logs_exports = ["postgresql"]
}