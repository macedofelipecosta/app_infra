variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/test/prod)"
  type        = string
}

variable "app_port" {
  description = "Port on which the app inside ECS listens"
  type        = number
  default     = 80
}

