resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = [var.subnet_1, var.subnet_2]
  tags = {
    "Name" : "Terraform"
  }

}

resource "aws_lb_target_group" "target" {
  name     = "${var.lb_name}"
  port     = 80
  protocol = var.lb_target_protocol
  vpc_id   = var.vpc_id
  tags = {
    "Terraform" : "Terraform"
  }
}


resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}
