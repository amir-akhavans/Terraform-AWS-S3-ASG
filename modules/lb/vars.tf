variable "lb_name" {
  # default = "Test"
}

variable "lb_target_protocol" {
  default = "HTTP"
}
variable "lb_listener_port" {
  default = "80"
}

variable "vpc_id" {
  default = "vpc-05a3df4c1be2f5ab4"
}

variable "security_group" {
  default = "sg-01bd5b15c203014b5"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_1" {
  default = "eu-west-1a"
}

variable "subnet_2" {
  default = "eu-west-1b"
}

