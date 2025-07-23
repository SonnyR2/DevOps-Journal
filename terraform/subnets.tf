resource "aws_subnet" "public" {
    count = length(local.public_subnets)

    vpc_id = aws_vpc.vpc.id
    cidr_block = local.public_subnets[count.index]
    availability_zone = local.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "Public-${local.azs[count.index]}"
    }
}

resource "aws_subnet" "private" {
    for_each = local.private_subnets
 
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value.cidr
    map_public_ip_on_launch = false
    availability_zone = each.value.az

    tags = {
      Name = "Private-${each.value.az}"
    }
}
