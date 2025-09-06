resource "aws_security_group" "sg_linux" {
  name        = "Linux-security-group"
  description = "Security-group para Linux"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "Linux-SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ssh_in" {
  security_group_id = aws_security_group.sg_linux.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "http_in" {
  security_group_id = aws_security_group.sg_linux.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}