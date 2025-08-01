output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "db_route_table_id" {
  value = aws_route_table.db.id
}
