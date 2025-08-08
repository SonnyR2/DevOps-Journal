output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "vpc_region" {
  value = var.region
}