output "instance_id" {
  description = "ID instância criada"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "IP público da instância"
  value       = aws_instance.web.public_ip
}
