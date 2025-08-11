terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "tfstoring123"     
    key            = "test/terraform.tfstate"  
    region         = "us-east-1"          
    use_lockfile   = true
    encrypt        = true                        
  }
}
