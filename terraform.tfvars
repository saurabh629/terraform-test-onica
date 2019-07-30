########################################################################
# Root Module / terraform.tfvars
########################################################################
aws_region          = "us-west-2"
project_name        = "project-terraform"
vpc_cidr            = "10.29.0.0/16"
public_cidrs        = ["10.29.1.0/24","10.29.2.0/24"]
accessip            = "0.0.0.0/0"
key_name            = "tf_key"
public_key_path     = "~/.ssh/id_rsa.pub"
server_instance_type= "t2.micro"
