resource "aws_vpc" "main" {
  cidr_block                = var.vpc_cidr
  instance_tenancy          = "default"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "sub_one" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr1
  availability_zone = var.az1
  tags = {
    Name = "Subnet One"
  }
}

resource "aws_subnet" "sub_two" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr2
  availability_zone = var.az2
  tags = {
    Name = "Subnet Two"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table for My VPC"
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.sub_one.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "my_vpc_us_east_1b_public" {
  subnet_id      = aws_subnet.sub_two.id
  route_table_id = aws_route_table.rt.id
}
