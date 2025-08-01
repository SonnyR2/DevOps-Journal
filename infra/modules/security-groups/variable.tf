variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "security_groups" {
  description = "Map of security groups with descriptions"
  type = map(object({
    description = string
  }))

  default = {
    allow_traffic = {
      description = "Allow HTTP/Postgres inbound traffic and all outbound traffic"
    }
    db_sg = {
      description = "Allow Postgres inbound traffic"
    }
  }
}

variable "ingress_rules" {
  description = "Map of ingress rule configurations"
  type = map(object({
    from_port = number
    to_port   = number
    sg_name   = string
  }))
  
  default = {
    http = {
      from_port = 80
      to_port   = 80
      sg_name   = "allow_traffic"
    }
    postgres = {
      from_port = 5432
      to_port   = 5432
      sg_name   = "allow_traffic"
    }
    postgres_db = {
      from_port = 5432
      to_port   = 5432
      sg_name   = "db_sg"
    }
  }
}
