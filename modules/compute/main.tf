########################################################################
# Compute Module / main.tf
########################################################################
# Get the AWS AMI with data block
data "aws_ami" "tf_server_ami" {
  most_recent = true
  owners      = ["099720109477"]
}

# Create an AWS Key pair
resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# Get the template for user-data to apply at instance init
data "template_file" "user-init" {
  template = "${file("${path.module}/userdata.tpl")}"
}

# Create a launch configuration 
resource "aws_launch_configuration" "tf_LC" {
  name_prefix                 = "tf_server-"
  image_id                    = "${data.aws_ami.tf_server_ami.id}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${var.security_groups}"]
  key_name                    = "${aws_key_pair.tf_auth.id}"
  user_data                   = "${data.template_file.user-init.template}"
  associate_public_ip_address = true
}

# Create an auto scaling group with launch configuration
resource "aws_autoscaling_group" "tf_ASG" {
  name                 = "${aws_launch_configuration.tf_LC.name}-ASG"
  min_size             = 2
  desired_capacity     = 2
  max_size             = 2
  launch_configuration = "${aws_launch_configuration.tf_LC.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  lifecycle {
    create_before_destroy = true
  }
}

# Create an application load balancer target group
resource "aws_lb_target_group" "tf_TG" {
  name_prefix = "TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
}

# Create an application load balancer and specify the listener
resource "aws_lb" "tf_LB" {
  name_prefix        = "LB-"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_groups}"]
  subnets            = ["${var.subnets}"]
}

resource "aws_lb_listener" "tf_LB" {
  load_balancer_arn = "${aws_lb.tf_LB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tf_TG.arn}"
  }
}

# Create an attachment for auto scaling group with target group
resource "aws_autoscaling_attachment" "tf_ASG_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.tf_ASG.id}"
  alb_target_group_arn   = "${aws_lb_target_group.tf_TG.arn}"
}
