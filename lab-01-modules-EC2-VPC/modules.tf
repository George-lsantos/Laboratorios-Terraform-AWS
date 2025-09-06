module "instance" {
    source = "./modules/instance"
    ec2_name = "ami-0360c520857e3138f"
    instance_type = "t3.micro"
    subnet_id = module.network.public_subnet_1a_id
    security_group_id = module.network.linux_sg_id
    
    tags_ec2 = {
        Name        = "SRV-Linux-01"
        Environment = "dev"
  }
#
}

module "network" {
  source = "./modules/network"
  aws_vpc = "10.13.0.0/16"
  private_cidr_block_east_1a = "10.13.0.0/24"
  private_cidr_block_east_1b = "10.13.16.0/24"
  public_cidr_block_east_1a = "10.13.32.0/24"
  public_cidr_block_east_1b = "10.13.48.0/24"
  
}
