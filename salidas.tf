output "vpc_id" {
  value       = aws_vpc.infra_vpc.id
  description = "ID de la VPC creada"
}

output "public_subnet_id" {
  value       = aws_subnet.infra_public_subnet.id
  description = "ID de la Subred Pública"
}

output "ec2_public_ip" {
  value       = aws_instance.infra_ec2_instance.public_ip
  description = "IP pública de la instancia EC2"
}
