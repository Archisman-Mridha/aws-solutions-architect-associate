variable "access_key" {
  type = string
  description = "AWS access key"
}

variable "secret_key" {
  type = string
  description = "AWS secret key"
}

variable "region" {
  type = string
  description = "AWS region"

  default = "us-east-2"
}

variable "availability_zones" {
  type = list(string)
  description = "AWS availability zones"

  default = [ "us-east-2a", "us-east-2b" ]
}