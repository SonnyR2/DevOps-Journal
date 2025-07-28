resource "aws_db_instance" "postgres" {
  identifier             = "my-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "17.4"
  instance_class         = "db.t4g.micro" # Free tier eligible
  db_name                = "${var.db_name}"
  username               = "${var.db_user}"
  password               = "${var.db_password}"
  vpc_security_group_ids = [aws_security_group.sg["db_sg"].id]
  db_subnet_group_name   =   aws_db_subnet_group.db.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}
