variable "vpc_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}