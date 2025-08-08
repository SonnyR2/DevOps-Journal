variable "region" {
  type    = string
  default = "us-east-1"
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "ecr_image" {
  description = "ECR URI"
  type        = string
}

variable "principal_arn" {
  description = "IAM role/user arn"
  type        = string
}

variable "public_access_cidr" {
  description = "ip cidr"
  type        = string
}