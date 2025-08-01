resource "aws_instance" "server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name

  tags = {
    Name = var.name
  }
}
