
#Variable VPC
variable "aws_vpc" {
  type        = string
  description = "cidr-block da VPC"
  
}

#Variable VPC CIDR Block da subnet Private
variable "private_cidr_block_east_1a" {
  type        = string
  description = "cidr block da subnet private us-east-1a"
}


variable "private_cidr_block_east_1b" {
  type        = string
  description = "cidr block da subnet private us-east-1b"
}

#Variable VPC CIDR Block da subnet Public
variable "public_cidr_block_east_1a" {
  type        = string
  description = "cidr block da subnet public us-east-1a"
  }

 variable "public_cidr_block_east_1b" {
  type        = string
  description = "cidr block da subnet private us-east-1b"
}
