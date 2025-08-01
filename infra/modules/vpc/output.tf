output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "db_subnet_ids" {
  description = "List of DB subnet IDs"
  value       = [for subnet in aws_subnet.db : subnet.id]
}

output "db_subnet_group_name" {
  description = "The name of the RDS DB subnet group"
  value       = aws_db_subnet_group.db.name
}

output "igw_id" {
    description = "IGW ID"
    value       = aws_internet_gateway.igw.id
}