terraform {
  backend "s3" {
    bucket         = "bucketterraformtest123454321"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}

module "launch_template" {
  source   = "../modules/launch_template"
  instance = "t2.micro"
  sg       = module.my_sg.sg
  ami      = "ami-0c1bc246476a5572b"
}

module "my_vpc" {
  source   = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "my_lb" {
  source             = "../modules/lb"
  lb_name            = "Terraform-Test"
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
  source           = "../modules/asg-template"
  min_size         = 1
  max_size         = 4
  desired_capacity = 1
  launch_template  = module.launch_template.launch_template_id
  subnet_1           = module.my_vpc.subnet_1
  subnet_2           = module.my_vpc.subnet_2
  alb                = module.my_lb.target_group
  
}

module "my_s3" {
  source      = "../modules/s3"
  bucket_name = "bucketterraformtest12345432123"
  acl         = "public-read-write"
}