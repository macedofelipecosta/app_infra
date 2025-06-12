# Permite a ECS asumir el rol
data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Rol de ejecución de tareas (para logs, pulling imágenes, etc.)
resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# Política AWS administrada para ejecución de tareas ECS (incluye logs, ECR, etc.)
resource "aws_iam_role_policy_attachment" "ecs_execution_attach" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Rol de la tarea (puede personalizarse para acceder a otros recursos, si necesitás)
resource "aws_iam_role" "ecs_task_role" {
  name               = "ecsAppTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}
