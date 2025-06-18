data "aws_iam_role" "labrole" {
  name = "LabRole"
}

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
module "ecs_cluster" {
  source       = "../../modules/ecs_cluster"
  cluster_name = var.cluster_name
  environment  = var.environment
}

module "ecr_vote" {
  source          = "../../modules/ecr"
  repository_name = "vote"
  force_delete    = true
  tags = {
    Environment = var.environment
  }
}

module "ecr_result" {
  source          = "../../modules/ecr"
  repository_name = "result"
  force_delete    = true
  tags = {
    Environment = var.environment
  }
}

module "ecr_worker" {
  source          = "../../modules/ecr"
  repository_name = "worker"
  force_delete    = true
  tags = {
    Environment = var.environment
  }
}


module "ecs_vote" {
  source                   = "../../modules/ecs_vote"
  cluster_name             = module.ecs_cluster.cluster_name
  cluster_id               = module.ecs_cluster.cluster_id
  task_family              = "vote-task"
  container_name           = "vote"
  container_port           = 80
  image                    = var.vote_image_url
  cpu                      = "256"
  memory                   = "512"
  desired_count            = 2
  subnet_ids               = module.network.private_subnet_ids
  security_group_ids       = [module.security_groups.ecs_sg_id]
  assign_public_ip         = true
  region                   = var.aws_region
  execution_role_arn       = data.aws_iam_role.labrole.arn
  task_role_arn            = data.aws_iam_role.labrole.arn
  target_group_arn         = module.alb.target_group_arn_vote
  listener_rule_depends_on = module.alb.listener_rule_vote

  tags = {
    Environment = var.environment
  }
}

module "vote_autoscaling" {
  source = "../../modules/autoscaling"

  service_name = module.ecs_vote.ecs_service_name
  cluster_name = module.ecs_cluster.cluster_name

  # Capacidad (ajustar según entorno)
  min_capacity = 2 # Mínimo para HA
  max_capacity = 6 # Máximo para picos de tráfico

  # Métrica basada en CPU (para carga de aplicación)
  target_value = 60 # 60% de uso de CPU objetivo
  metric_type  = "ECSServiceAverageCPUUtilization"

  # Alternativa métrica basada en requests (si usa ALB):
  # target_value = 500  # Requests por target/minuto
  # metric_type  = "ALBRequestCountPerTarget"

  # Cooldowns
  scale_out_cooldown = 120 # Escalar rápido en picos
  scale_in_cooldown  = 300 # Reducir más lento para evitar fluctuaciones
}

module "ecs_result" {
  source                   = "../../modules/ecs_result"
  cluster_name             = module.ecs_cluster.cluster_name
  cluster_id               = module.ecs_cluster.cluster_id
  task_family              = "result-task"
  container_name           = "result"
  container_port           = 80
  image                    = var.result_image_url
  cpu                      = "256"
  memory                   = "512"
  desired_count            = 2
  subnet_ids               = module.network.private_subnet_ids
  security_group_ids       = [module.security_groups.ecs_sg_id]
  assign_public_ip         = true
  region                   = var.aws_region
  execution_role_arn       = data.aws_iam_role.labrole.arn
  task_role_arn            = data.aws_iam_role.labrole.arn
  target_group_arn         = module.alb.target_group_arn_result
  listener_rule_depends_on = module.alb.listener_rule_result

  tags = {
    Environment = var.environment
  }
}

module "result_autoscaling" {
  source = "../../modules/autoscaling"

  service_name = module.ecs_result.ecs_service_name
  cluster_name = module.ecs_cluster.cluster_name

  # Configuración de capacidad
  min_capacity = 2
  max_capacity = 4

  # Métricas de escalado
  target_value = 50                                # 50% CPU utilización objetivo
  metric_type  = "ECSServiceAverageCPUUtilization" # Explícito es mejor

  # Tiempos de cooldown
  scale_out_cooldown = 120 # 2 minutos para escalar hacia arriba
  scale_in_cooldown  = 300 # 5 minutos para escalar hacia abajo (más conservador)
}

module "ecs_worker" {
  source             = "../../modules/ecs_worker"
  cluster_id         = module.ecs_cluster.cluster_id
  task_family        = "worker-task"
  container_name     = "redis"
  container_port     = 6379
  image              = var.worker_image_url
  cpu                = "256"
  memory             = "512"
  desired_count      = 2
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_worker_sg_id]
  assign_public_ip   = true
  region             = var.aws_region
  execution_role_arn = data.aws_iam_role.labrole.arn
  task_role_arn      = data.aws_iam_role.labrole.arn


  tags = {
    Environment = var.environment
  }
}

module "worker_autoscaling" {
  source = "../../modules/autoscaling"

  service_name = module.ecs_worker.ecs_service_name
  cluster_name = module.ecs_cluster.cluster_name

  # Capacidad (workers pueden ser más elásticos)
  min_capacity = 2  # Puede ser 1 en desarrollo
  max_capacity = 10 # Escalar agresivamente bajo carga

  # Métrica basada en CPU (workers pueden ser intensivos en CPU)
  target_value = 70 # 70% CPU utilización objetivo (workers pueden ser intensivos en CPU)
  metric_type  = "ECSServiceAverageCPUUtilization"

  # Cooldowns más largos (workers tardan más en inicializarse)
  scale_out_cooldown = 180
  scale_in_cooldown  = 600 # 10 minutos para evitar escalado prematuro
}


module "redis" {
  source             = "../../modules/redis"
  region             = var.aws_region
  cluster_id         = module.ecs_cluster.cluster_id
  execution_role_arn = data.aws_iam_role.labrole.arn
  task_role_arn      = data.aws_iam_role.labrole.arn
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security_groups.ecs_worker_sg_id] # uno que permita puerto 6379
}
