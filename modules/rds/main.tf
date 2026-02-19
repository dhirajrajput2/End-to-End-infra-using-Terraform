resource "aws_db_subnet_group" "db_subnet" {
  name       = "project1-db-subnet"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "project1-db-subnet"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot  = true
}
