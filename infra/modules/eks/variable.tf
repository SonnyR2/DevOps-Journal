variable "cluster_name" {
  description = "The name of the EKS Cluster"
  type        = string
  default     = "journal-cluster"
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}

variable "eks_principle_arn" {
  description = "IAM role/user arn"
  type        = string
}

variable "public_access_cidr" {
    description = "ip cidr"
    type = string
}