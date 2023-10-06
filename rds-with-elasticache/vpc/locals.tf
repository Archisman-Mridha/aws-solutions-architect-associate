locals {
  vpc_cidr_block = "10.0.0.0/16"

  public_subnet_count= 1
  private_subnet_count = 2

  total_subnet_count = local.public_subnet_count + local.private_subnet_count
}