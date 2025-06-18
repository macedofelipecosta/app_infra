resource "aws_cloudwatch_log_group" "ecs_worker" {
  name              = "/ecs/worker"
  retention_in_days = 7
}


resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  depends_on = [
    aws_cloudwatch_log_group.ecs_worker
  ]

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.container_name}"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "worker-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
    security_groups  = var.security_group_ids
  }
  health_check_grace_period_seconds  = 60
  deployment_minimum_healthy_percent = 100

  depends_on = [
    aws_ecs_task_definition.this,
    var.listener_rule_depends_on
  ]
  tags = var.tags

}
