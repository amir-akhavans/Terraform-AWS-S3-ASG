terraform {
  backend "s3" {
    bucket         = "bucketterraformtest123454321"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}

module "launch_config" {
  source = "../modules/launch_config"
  sg     = module.my_sg.sg
}

module "my_vpc" {
  source   = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "my_lb" {
  source             = "../modules/lb"
  lb_name            = "TerraformTest"
  lb_target_protocol = "HTTP"
  lb_listener_port   = "8080"
  vpc_id             = module.my_vpc.vpc_id
  subnet_1           = module.my_vpc.subnet_1
  subnet_2           = module.my_vpc.subnet_2
  security_group     = module.my_sg.sg
}

module "my_sg" {
  source = "../modules/sg"
  my_vpc = module.my_vpc.vpc_id
  service_ports = {
    from_port = 80
    to_port   = 80
  }
}

module "my_asg" {
  source = "../modules/asg-config"
  min_size         = 1
  max_size         = 4
  desired_capacity = 1
  subnet_1      = module.my_vpc.subnet_1
  subnet_2      = module.my_vpc.subnet_2
  alb           = module.my_lb.target_group
  launch_config = module.launch_config.launch_name
}

module "my_s3" {
  source      = "../modules/s3"
  bucket_name = "bucketterraformtest123454321"
  acl         = "public-read-write"
  dynamodb_table = "terraform-state-lock"
}


