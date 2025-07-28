locals {

    public_subnets = {

        public-1 = {
            cidr = "10.0.0.0/28"
            az = "us-east-1a"
        }

        public-2 = {
            cidr = "10.0.0.16/28"
            az = "us-east-1b"            
        }
    }

    db_subnet = {
        db-subnet-1 = {
            cidr = "10.0.0.32/28"
            az = "us-east-1a"            
        }

        db-subnet-2 = {
            cidr = "10.0.0.48/28"
            az = "us-east-1b"            
        }
    }
}

locals {
  
    security_groups = {

        allow_traffic = {
            description = "Allow HTTP/Postgres inbound traffic and all outbound traffic"
        }

        db_sg = {
            description = "Allow Postgres inbound traffic"
        }
    }

    ingress = {

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