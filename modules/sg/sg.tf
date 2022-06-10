resource "aws_security_group" "sg" {
  name        = "Terraform Test"
  vpc_id      = var.my_vpc
  
  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol       = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "Terraform-Test"
  }
  depends_on = [
    var.my_vpc
    # var.launch_template
   ]
}