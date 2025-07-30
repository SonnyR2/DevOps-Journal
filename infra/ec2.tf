resource "aws_instance" "server" {
  #needed to connect and make a table in PostgresDB
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg["allow_traffic"].id]
  subnet_id              = aws_subnet.public["public-1"].id
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  key_name               = "key"

  tags = {
    Name = "db-editor"
  }
}