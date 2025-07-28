
resource "aws_subnet" "public" {
    for_each = local.public_subnets
 
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value.cidr
    map_public_ip_on_launch = true
    availability_zone = each.value.az

    tags = {
      Name = "Public-${each.value.az}"
    }
}

resource "aws_subnet" "db" {
  for_each = local.db_subnet

  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value.cidr
  map_public_ip_on_launch = false
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_db_subnet_group" "db" {
  
  name       = "postgresdb"
  subnet_ids = [for s in aws_subnet.db : s.id]

  tags = {
    Name = "postgres"
  }
}
