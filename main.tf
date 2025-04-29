module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "ecr" {
  source = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
 }

module "kinesis" {
  source = "./modules/kinesis"

  project_name = var.project_name
  environment  = var.environment
}

module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  environment  = var.environment
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  environment         = var.environment
  aws_region          = var.aws_region
  db_username         = "fraudadmin"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
}

module "iam" {
  source        = "./modules/iam"
  project_name  = var.project_name
  environment   = var.environment
  aws_region    = var.aws_region
  aws_account_id = "590183956481" # ✅ Your AWS Account ID
}
