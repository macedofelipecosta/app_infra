output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

output "ecs_worker_sg_id" {
  value = aws_security_group.ecs_worker_sg.id
}

