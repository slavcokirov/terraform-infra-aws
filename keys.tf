resource "tls_private_key" "exampleapp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "exampleapp" {
  key_name   = "exampleapp-key"
  public_key = tls_private_key.exampleapp.public_key_openssh
}
