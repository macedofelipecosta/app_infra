module "network" {
  source          = "../../modules/network"
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  environment     = var.environment
}

module "security_groups" {

  source      = "../../modules/security"

  vpc_id      = module.network.vpc_id
  environment = var.environment
  app_port    = var.app_port
}

module "alb" {
  source             = "../../modules/loadbalancer"
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  security_group_ids = [module.security_groups.alb_sg_id]
  environment        = var.environment


}
data "aws_iam_role"  "labrole" {
  name = "LabRole"
}
module "ecr_vote" {
  source           = "../../modules/ecr"
  repository_name  = "vote"
  force_delete     = true
  tags = {
    Environment = var.environment
  }
}

module "ecr_result" {
  source           = "../../modules/ecr"
  repository_name  = "result"
  force_delete     = true
  tags = {
    Environment = var.environment
  }
}

module "ecr_worker" {
  source           = "../../modules/ecr"
  repository_name  = "worker"
  force_delete     = true
  tags = {
    Environment = var.environment
  }
}


module "ecs_vote" {
  source             = "../../modules/ecs_fargate"
  cluster_name       = var.cluster_name
  task_family        = "vote-task"
  container_name     = "vote"
  container_port     = 80
  image              = var.vote_image_url
  cpu                = "256"
  memory             = "512"
  desired_count      = 1
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = data.aws_iam_role.labrole.arn
  task_role_arn      = data.aws_iam_role.labrole.arn
  target_group_arn   = module.alb.target_group_arn_vote
  listener_rule_depends_on = module.alb.listener_rule_vote

  tags = {
    Environment = var.environment
  }
}

module "ecs_result" {
  source             = "../../modules/ecs_fargate"
  cluster_name       = var.cluster_name
  task_family        = "result-task"
  container_name     = "result"
  container_port     = 80
  image              = var.result_image_url
  cpu                = "256"
  memory             = "512"
  desired_count      = 1
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = data.aws_iam_role.labrole.arn
  task_role_arn      = data.aws_iam_role.labrole.arn
  target_group_arn   = module.alb.target_group_arn_result
  listener_rule_depends_on = module.alb.listener_rule_result

  tags = {
    Environment = var.environment
  }
}

module "ecs_worker" {
  source             = "../../modules/ecs_worker"
  cluster_name       = var.cluster_name
  task_family        = "worker-task"
  container_name     = "worker"
  container_port     = 80
  image              = var.worker_image_url
  cpu                = "256"
  memory             = "512"
  desired_count      = 1
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = data.aws_iam_role.labrole.arn
  task_role_arn      = data.aws_iam_role.labrole.arn


  tags = {
    Environment = var.environment
  }
}


