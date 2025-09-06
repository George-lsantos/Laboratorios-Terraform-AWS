# ID da VPC
output "vpc_id" {
  description = "ID VPC criada"
  value       = aws_vpc.vpc.id
}

# ID das subnets privadas
output "private_subnet_1a_id" {
  description = "ID da subnet privada us-east-1a"
  value       = aws_subnet.sub_private_us_east_1a.id
}

output "private_subnet_1b_id" {
  description = "ID da subnet privada us-east-1b"
  value       = aws_subnet.sub_private_us_east_1b.id
}

# ID das subnets públicas
output "public_subnet_1a_id" {
  description = "ID da subnet pública us-east-1a"
  value       = aws_subnet.sub_public_us_east_1a.id
}

output "public_subnet_1b_id" {
  description = "ID da subnet pública us-east-1b"
  value       = aws_subnet.sub_public_us_east_1b.id
}


output "linux_sg_id" {
  description = "ID do Security Group Linux"
  value       = aws_security_group.sg_linux.id
}




