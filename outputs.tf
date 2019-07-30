########################################################################
# Root Module / outputs.tf
########################################################################
# Networking outputs
output "Public SG" {
  value = "${module.networking.public_sg}"
}

output "Public Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}

output "Subnet IPs" {
  value = "${join(", ", module.networking.subnet_ips)}"
}

# Compute outputs
output "Server AMI" {
  value = "${module.compute.tf_ami_name}"
}

output "ALB dns" {
  value = "${module.compute.tf_lb}"
}
