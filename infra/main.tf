module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
}

module "routes" {
  source = "./modules/routes"

  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.vpc_cidr
  igw_id         = module.vpc.igw_id
  public_subnets = module.vpc.public_subnet_ids
  db_subnets     = module.vpc.db_subnet_ids
}

module "iam" {
  source = "./modules/iam"
}

module "rds" {
  source = "./modules/rds"

  db_name              = var.db_name
  db_user              = var.db_user
  db_password          = var.db_password
  security_group_id    = module.security_groups.security_group_ids["db_sg"]
  db_subnet_group_name = module.vpc.db_subnet_group_name
}

module "eks" {
  source = "./modules/eks"

  subnet_ids         = module.vpc.public_subnet_ids
  public_access_cidr = var.public_access_cidr
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  eks_principle_arn  = var.principal_arn
  depends_on         = [module.iam] # This ensures the IAM module runs first
}

/*
module "ecs" {
  source = "./modules/ecs"

  ecr_image          = var.ecr_image
  db_user            = var.db_user
  db_password        = var.db_password
  db_name            = var.db_name
  db_endpoint        = module.rds.db_endpoint
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_id  = module.security_groups.security_group_ids["allow_traffic"]
}

module "ec2" {
  source = "./modules/ec2"

  security_group_id    = module.security_groups.security_group_ids["allow_traffic"]
  subnet_id            = module.vpc.public_subnet_ids[0]
  iam_instance_profile = module.iam.ssm_instance_profile_name
}
*/
