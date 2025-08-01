resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "igw-route"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "db" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "db-route-table"
  }
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnets)

  subnet_id      = var.db_subnets[count.index]

  route_table_id = aws_route_table.db.id
}