
resource "aws_launch_template" "launch_template" {
  name                                 = "Terraform-Test"
  image_id                             = var.ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance
  vpc_security_group_ids               = [var.sg]

  # iam_instance_profile {
  #   name = "test"
  # }

  monitoring {
    enabled = true
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Terraform Test"

    }
    # }
    # depends_on = [var.sg]
  }
}