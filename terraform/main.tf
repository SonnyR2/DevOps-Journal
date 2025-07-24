resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"

    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
      Name = "Journal-VPC"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "API-IGW"
    }
}

resource "aws_eip" "nat-ip" {
    domain = "vpc"

    tags = {
      Name = "nat-ip"
    }
    depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_nat_gateway" "nat" {

    allocation_id = aws_eip.nat-ip.id
    subnet_id = aws_subnet.public[0].id

    tags = {
      Name = "nat"
    }
}

resource "aws_iam_role" "ssm_role" {
  name = "EC2_SSM_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}


resource "aws_instance" "server" {
  count = length(aws_subnet.public)

  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg["allow_tls"].id]
  subnet_id = aws_subnet.public[count.index].id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  key_name = "key"

  tags = {
    Name = "API-Server-${count.index + 1}"
  }
}

resource "aws_instance" "database" {
  for_each = aws_subnet.private

  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg["allow_postgres"].id]
  subnet_id = each.value.id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "Database-${each.key}"
  }
}