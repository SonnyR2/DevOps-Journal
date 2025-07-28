
resource "aws_route_table" "public-routes" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "igw-route"
    } 
}

resource "aws_route_table_association" "public_zone" {
    for_each = local.public_subnets

    subnet_id = aws_subnet.public[each.key].id
    route_table_id = aws_route_table.public-routes.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "db-route-table"
  }
}

resource "aws_route_table_association" "db_subnet" {
for_each = aws_subnet.db

  subnet_id      = aws_subnet.db[each.key].id
  route_table_id = aws_route_table.db.id
}
