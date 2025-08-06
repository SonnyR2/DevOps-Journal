variable "vpc_cidr" {
    type = string
    description = "vpc cidr value"
    default = "10.0.0.0/16"
  
}

variable "public_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr = string
    az   = string
  }))
  
  default = {
    public-1 = {
      cidr = "10.0.0.0/27"
      az   = "us-east-1a"
    }
    public-2 = {
      cidr = "10.0.0.32/27"
      az   = "us-east-1b"
    }
  }
}

variable "db_subnets" {
  description = "Map of database subnet configurations"
  type = map(object({
    cidr = string
    az   = string
  }))

  default = {
    db-subnet-1 = {
      cidr = "10.0.0.64/28"
      az   = "us-east-1a"
    }
    db-subnet-2 = {
      cidr = "10.0.0.80/28"
      az   = "us-east-1b"
    }
  }
}
