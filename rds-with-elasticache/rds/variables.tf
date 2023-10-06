variable "vpc_id" {
  type = string
  description = "Id of the VPC containing all these resources"
}

variable "availability_zones" {
  type = list(string)
  description = "AWS availability zones"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Ids of the private subnets included in the DB subnet group"
}