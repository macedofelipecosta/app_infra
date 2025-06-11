module "network" {
  source          = "../../modules/network"
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  environment     = var.environment
}

module "security_groups" {
  source      = "../../modules/security-groups"
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
  target_port        = var.app_port
}

module "ecs_fargate" {
  source             = "../../modules/ecs_fargate"
  environment        = var.environment
  service_name       = "ecs_fargate_voting_app"
  image_url          = var.vote_image_url
  container_port     = var.app_port
  desired_count      = 1
  subnet_ids         = module.network.private_subnet_ids
  cpu                = "256"
  memory             = "512"
  security_group_ids = [module.security_groups.ecs_sg_id]
  target_group_arn   = module.alb.target_group_arn
  vpc_id             = module.network.vpc_id
  aws_region         = var.aws_region

}

