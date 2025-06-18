
variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio ECS"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "log_retention_days" {
  description = "Días de retención de logs en CloudWatch"
  type        = number
  default     = 30
}

variable "cpu_threshold" {
  description = "Umbral de CPU para alertas"
  type        = number
  default     = 70
}

variable "memory_threshold" {
  description = "Umbral de memoria para alertas"
  type        = number
  default     = 80
}

variable "alarm_actions" {
  description = "ARNs de acciones a ejecutar (ej: SNS topics)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags comunes para los recursos"
  type        = map(string)
  default     = {}
}
variable "cpu_evaluation_periods" {
  description = "Períodos de evaluación para alarmas de CPU"
  type        = number
  default     = 5
}
variable "memory_evaluation_periods" {
  description = "Períodos de evaluación para alarmas de memoria"
  type        = number
  default     = 5
}