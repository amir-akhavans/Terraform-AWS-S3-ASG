resource "aws_autoscaling_group" "web" {
  name = "Terraform"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type = "ELB"
  target_group_arns = [
    var.alb
  ]

   launch_template {
    id = var.launch_template
    version = "$Latest"
  }

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    var.subnet_1,
    var.subnet_2
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "Terraform-Test"
    propagate_at_launch = true
  }
}