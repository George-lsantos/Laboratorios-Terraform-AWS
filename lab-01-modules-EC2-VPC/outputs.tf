# Outputs do módulo network.
output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnet_1a_id" {
  value = module.network.private_subnet_1a_id
}

output "private_subnet_1b_id" {
  value = module.network.private_subnet_1b_id
}

output "linux_sg_id" {
  value = module.network.linux_sg_id
  
}

# Outputs do módulo instance
output "instance_id" {
  value = module.instance.instance_id
}

output "instance_public_ip" {
  value = module.instance.instance_public_ip
}
