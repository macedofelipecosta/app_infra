

#ESte recurso establece la cantidad mínima y máxima de instancias que el servicio ECS puede escalar.
resource "aws_appautoscaling_target" "target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scaling_policy" {
  name               = "${var.service_name}-scaling"
  policy_type        = "TargetTrackingScaling" # Tipo de política de escalado, ajusta el numero de tareas basado en una metrica objetivo
  resource_id        = aws_appautoscaling_target.target.resource_id
  scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.target.service_namespace

  target_tracking_scaling_policy_configuration {
    #Defime como y cuando escalar en funcion de la metrica objetivo
    target_value       = var.target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
    
    predefined_metric_specification {
      #Define que metrica se va utilizar para el escalado (CPU, Memoria, ALBRequestCount, etc.)
      predefined_metric_type = var.metric_type
    }
  }
}