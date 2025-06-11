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

module "ecs_fargate" {
  source             = "../../modules/ecs_fargate"
  cluster_name       = var.cluster_name
  task_family        = var.task_family
  container_name     = var.container_name
  container_port     = var.app_port
  image              = var.vote_image_url
  cpu                = "256"
  memory             = "512"
  desired_count      = 1
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_sg_id]
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  target_group_arn   = module.alb.target_group_arn_vote
  tags = {
    Environment = var.environment
  }
}


