output "ssm_role_name" {
  value = aws_iam_role.ssm_role.name
}

output "ssm_instance_profile_name" {
  value = aws_iam_instance_profile.ssm_profile.name
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "cluster_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
