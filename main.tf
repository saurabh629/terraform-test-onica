########################################################################
# Root Module / main.tf
########################################################################

# Deploy AWS provider
provider "aws" {
  region = "${var.aws_region}"
}

# Deploy Networking Resources
module "networking" {
  source       = "./modules/networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip     = "${var.accessip}"
}

# Deploy Compute Resources
module "compute" {
  source          = "./modules/compute"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"

  //instance_count  = "${var.instance_count}"
  subnets         = "${module.networking.public_subnets}"
  security_groups = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
  vpc_id          = "${module.networking.vpc_id}"
}
