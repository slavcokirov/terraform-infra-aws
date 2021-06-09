resource "tls_private_key" "exampleapp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "exampleapp" {
  key_name   = "exampleapp-key"
  public_key = tls_private_key.exampleapp.public_key_openssh
}

resource "random_shuffle" "subnets" {
  input        = tolist(aws_subnet.public.*.id)
  result_count = 1
}

resource "aws_instance" "exampleapp" {
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"

  associate_public_ip_address = true
  subnet_id                   = "${random_shuffle.subnets.result[0]}"
  vpc_security_group_ids      = [aws_security_group.sg_https.id, aws_security_group.sg_ssh.id]

  key_name = aws_key_pair.exampleapp.key_name

  tags = {
    Name = "exampleapp-server"
  }
}
