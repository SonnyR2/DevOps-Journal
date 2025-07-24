locals {
    azs = ["us-east-1a", "us-east-1b"]
    public_subnets = ["10.0.0.0/28", "10.0.0.16/28"]

    private_subnets = {

        private-1 = {
            cidr = "10.0.0.32/28"
            az = "us-east-1a"
        }

        private-2 = {
            cidr = "10.0.0.48/28"
            az = "us-east-1b"            
        }
    }

    security_groups = {

        allow_tls = {
            description = "Allow TLS/SSH inbound traffic and all outbound traffic"
        }

        allow_postgres = {
            description   = "Allow Postgres inbound traffic and all outbound traffic"
        }
    }

    ingress = {
        tls = {
            from_port = 443
            to_port   = 443
            sg_name   = "allow_tls"
        }
        ssh = {
            from_port = 22
            to_port   = 22
            sg_name   = "allow_tls"
        }
        postgres = {
            from_port = 5432
            to_port   = 5432
            sg_name   = "allow_postgres"
        }
        extra = {
            from_port = 5432
            to_port   = 5432
            sg_name   = "allow_tls"
        }  
    }
}