resource "aws_security_group" "web01-sg" {
  name        = "web01-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.web01.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web01_allow_tls"
  }
}
