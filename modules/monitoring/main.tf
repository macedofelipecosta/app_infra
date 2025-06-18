resource "aws_cloudwatch_log_group" "service_logs" {
  name              = "/ecs/${var.environment}-${var.service_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "${var.environment}-${var.service_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.cpu_evaluation_periods
  threshold           = var.cpu_threshold
  alarm_description   = "Alerta cuando uso de CPU excede ${var.cpu_threshold}%"
  alarm_actions       = var.alarm_actions

  metric_query {
    id          = "e1"
    expression  = "SELECT AVG(CPUUtilization) FROM SCHEMA(\"AWS/ECS\", ServiceName, ClusterName) WHERE ServiceName = '${var.service_name}' AND ClusterName = '${var.cluster_name}'"
    label       = "CPU Utilization"
    return_data = true
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  alarm_name          = "${var.environment}-${var.service_name}-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.memory_evaluation_periods
  threshold           = var.memory_threshold
  alarm_description   = "Alerta cuando uso de memoria excede ${var.memory_threshold}%"
  alarm_actions       = var.alarm_actions

  metric_query {
    id          = "e1"
    expression  = "SELECT AVG(MemoryUtilization) FROM SCHEMA(\"AWS/ECS\", ServiceName, ClusterName) WHERE ServiceName = '${var.service_name}' AND ClusterName = '${var.cluster_name}'"
    label       = "Memory Utilization"
    return_data = true
  }

  tags = var.tags
}