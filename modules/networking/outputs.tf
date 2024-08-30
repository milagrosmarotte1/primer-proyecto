output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  description = "IDs de las subnets creadas"
  value       = aws_subnet.public_subnet[*].id
}