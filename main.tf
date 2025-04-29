module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

# module "ecr" {
#   source = "./modules/ecr"
#   project_name = var.project_name
#   environment  = var.environment
# }

# module "kinesis" {
#   source = "./modules/kinesis"
#   project_name = var.project_name
#   environment  = var.environment
# }

# module "ecs" {
#   source = "./modules/ecs"
#   project_name = var.project_name
#   environment  = var.environment
# }

# module "rds" {
#   source = "./modules/rds"
#   project_name = var.project_name
#   environment  = var.environment
#   aws_region   = var.aws_region
# }

# module "iam" {
#   source = "./modules/iam"
#   project_name = var.project_name
#   environment  = var.environment
# }