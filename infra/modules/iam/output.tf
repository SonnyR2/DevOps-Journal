output "ssm_role_name" {
  value = aws_iam_role.ssm_role.name
}

output "ssm_instance_profile_name" {
  value = aws_iam_instance_profile.ssm_profile.name
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}
