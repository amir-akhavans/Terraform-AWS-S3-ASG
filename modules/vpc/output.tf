output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_1" {
  value = aws_subnet.sub_one.id
}

output "subnet_2" {
  value = aws_subnet.sub_two.id
}
