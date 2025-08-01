variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC"
}

variable "igw_id" {
  type        = string
  description = "ID of the Internet Gateway"
}

variable "public_subnets" {
  type = list(string)
  description = "Public subnet IDs"
}

variable "db_subnets" {
  type = list(string)
  description = "DB subnet IDs"
}
