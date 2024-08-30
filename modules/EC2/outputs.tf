output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.my_ec2[*].id
}

output "public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.my_ec2[*].public_ip
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.my_alb.dns_name
}