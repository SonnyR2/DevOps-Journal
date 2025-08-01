
variable "db_name" {
  type        = string
}

variable "db_user" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "security_group_id" {
  type        = string
}

variable "db_subnet_group_name" {
  type        = string
}