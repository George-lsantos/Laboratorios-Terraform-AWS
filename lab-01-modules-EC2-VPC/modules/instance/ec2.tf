resource "aws_key_pair" "my_key" {
  key_name   = "KP-Linux"
  public_key = file("${path.module}/../../my-ec2-key.pub")
}


resource "aws_instance" "web" {
  ami           = var.ec2_name
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]  # recebe via variável
  key_name = aws_key_pair.my_key.key_name  # associação da chave
  # Poderia incluir a chave que foi criada na console da AWS ->  key_name = "my-key"
  associate_public_ip_address = true  # <--- isso atribui um IP público automático
  tags = var.tags_ec2

    # Configuração do volume root
    root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    iops                  = 3000
    encrypted             = false
  }

}

