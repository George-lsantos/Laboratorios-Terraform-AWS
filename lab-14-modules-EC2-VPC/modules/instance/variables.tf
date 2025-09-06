variable "ec2_name"{
  type = string
  description = "Nome da instância do Ec2"
}

variable "instance_type" {
  type = string
  description = "Amb. que será provisionado"
}

variable "tags_ec2" {
 type    = map(string)

}

variable "subnet_id" {
  type        = string
  description = "Subnet onde a instância será criada"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID para a instância"
}
