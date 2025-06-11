variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups to associate with ALB"
  type        = list(string)
}

variable "target_port_vote" {
  type        = number
  default     = 80
  description = "Puerto interno del contenedor vote"
}

variable "target_port_result" {
  type        = number
  default     = 80
  description = "Puerto interno del contenedor result"
}


