resource "aws_security_group" "sg_https" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "exampleapp-sg-https"
  }
}

resource "aws_security_group" "sg_ssh" {
  name        = "allow_ssh"
  description = "Allow SSh inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["92.53.22.231/32"]
  }

  tags = {
    Name = "exampleapp-sg-ssh"
  }
}
