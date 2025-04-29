output "cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution IAM Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}
