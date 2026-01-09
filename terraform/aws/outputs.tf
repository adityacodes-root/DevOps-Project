output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The DNS name of the load balancer"
}

output "backend_service_name" {
    value = aws_ecs_service.backend.name
}

output "frontend_service_name" {
    value = aws_ecs_service.frontend.name
}
