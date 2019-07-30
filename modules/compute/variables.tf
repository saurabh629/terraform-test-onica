########################################################################
# Compute Module / variables.tf
########################################################################
variable "key_name" {}

variable "public_key_path" {}
variable "instance_type" {}
variable "security_groups" {}

variable "subnets" {
  type = "list"
}

variable "subnet_ips" {
  type = "list"
}

variable "vpc_id" {}
