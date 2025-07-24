resource "aws_security_group" "sg" {
  for_each = local.security_groups

  name        = each.key
  description = each.value.description
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = each.key
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules" {
    for_each = local.ingress
    security_group_id = aws_security_group.sg[each.value.sg_name].id
    cidr_ipv4         = aws_vpc.vpc.cidr_block
    from_port         = each.value.from_port
    ip_protocol       = "tcp"
    to_port           = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each = local.security_groups

  security_group_id = aws_security_group.sg[each.key].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}