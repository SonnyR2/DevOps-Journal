variable "ecr_image" {
  description = "ECR image URI"
  type        = string
}

variable "db_user" {
  description = "DB username"
  type        = string
}

variable "db_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "DB name"
  type        = string
}

variable "db_endpoint" {
  description = "Postgres DB endpoint"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM Role ARN for ECS task execution"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for ECS task"
  type        = string
}
