resource "aws_db_instance" "db" {
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.5.8"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "devops"
  password             = random_password.pass_db.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_group.id
}

resource "random_password" "pass_db" {
  length           = 16
  special          = true
  override_special = "_%"
}

resource "aws_db_subnet_group" "db_group" {
  name       = "db_subnet_group"
  subnet_ids = tolist(aws_subnet.dbsns.*.id)

  tags = {
    Name = "My DB subnet group"
  }
}
