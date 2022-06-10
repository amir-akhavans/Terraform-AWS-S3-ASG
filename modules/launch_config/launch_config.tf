data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values     = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_launch_configuration" "web" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance
  security_groups = ["${var.sg}"]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}