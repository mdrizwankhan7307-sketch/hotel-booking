output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.Public.id,
    aws_subnet.Public1.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.Private.id,
    aws_subnet.Private1.id
  ]
}