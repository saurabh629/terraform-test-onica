########################################################################
# Compute Module / outputs.tf
########################################################################
# Output AMI name
output "tf_ami_name" {
  value = "value${data.aws_ami.tf_server_ami.name}"
}

# Output LB dns endpoint
output "tf_lb" {
  value = "${aws_lb.tf_LB.dns_name}"
}
