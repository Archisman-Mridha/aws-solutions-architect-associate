terraform {
  required_version = ">= 1.5.3"

  backend "local" { }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = var.region

  access_key = var.access_key
  secret_key = var.secret_key

  default_tags {
    tags = {
      "project" = "aws-solutions-architect-associate"
    }
  }
}

// Creates a VPC with a public and private subnet.
module "vpc" {
  source = "./vpc"

  availability_zones = var.availability_zones
}

// Creates an RDS instance with a RDS proxy.
module "rds" {
  source = "./rds"

  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones
  private_subnet_ids = module.vpc.private_subnet_ids
}