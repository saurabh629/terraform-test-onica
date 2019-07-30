########################################################################
# Root Module / variables.tf
########################################################################
#------------  root/variables.tf --------------------
variable "project_name" {}

variable "aws_region" {}

#------------  networking/variables.tf --------------
variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}

#------------  compute/variables.tf --------------
variable "public_key_path" {}

variable "key_name" {}
variable "server_instance_type" {}
