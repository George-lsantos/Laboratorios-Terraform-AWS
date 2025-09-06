
#Criação de VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc
  instance_tenancy     = "default "
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-HMG"
  }
}
#Criação de IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.vpc_tag.igw
}

#criação de subnet private
resource "aws_subnet" "sub_private_us_east_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_block_east_1a
  availability_zone = local.subnet_config.az_1a
  tags              = local.vpc_tag.subnet_private
}

resource "aws_subnet" "sub_private_us_east_1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_block_east_1b
  availability_zone = local.subnet_config.az_1b
  tags              = local.vpc_tag.subnet_private
}

#criação de subnet public
resource "aws_subnet" "sub_public_us_east_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_block_east_1a
  availability_zone = local.subnet_config.az_1a
  tags              = local.vpc_tag.subnet_public
}

resource "aws_subnet" "sub_public_us_east_1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_block_east_1b
  availability_zone = local.subnet_config.az_1b
  tags              = local.vpc_tag.subnet_public
}

#Criação de RTB Private
resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RTB-Private"
  }
}

#Criação de RTB Public
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.vpc_tag.rtb_public
}

# Association RT com subnet public
resource "aws_route_table_association" "rtb_sub_public_us_east_1a" {
  subnet_id      = aws_subnet.sub_public_us_east_1a.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "rtb_sub_public_us_east_1b" {
  subnet_id      = aws_subnet.sub_public_us_east_1b.id
  route_table_id = aws_route_table.rtb_public.id
}

# Criação de NAT
# Criar Elastic IP para o NAT Gateway, NAT Gateway precisa de um Elastic IP e deve estar em uma subnet pública.
# Criar Elastic IP para o NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Criar NAT Gateway na subnet pública
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.sub_public_us_east_1a.id  # O NAT Gateway precisa estar em uma subnet pública

  tags = {
    Name = "nat-gateway"
  }
}

# Associar a RTB privada às Subnets Privadas
resource "aws_route_table_association" "rtb_sub_private_us_east_1a" {
  subnet_id      = aws_subnet.sub_private_us_east_1a.id
  route_table_id = aws_route_table.rtb_private.id
}

resource "aws_route_table_association" "rtb_sub_private_us_east_1b" {
  subnet_id      = aws_subnet.sub_private_us_east_1b.id
  route_table_id = aws_route_table.rtb_private.id
}


# NAT Gateway ao Route Table privado
# Rota na tabela privada apontando para o NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.rtb_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
