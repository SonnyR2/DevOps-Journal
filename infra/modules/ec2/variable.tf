variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
} #allow_traffic

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
} #public1

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
  default     = "key"
}

variable "name" {
  description = "Tag name for the instance"
  type        = string
  default     = "db-editor"
}
