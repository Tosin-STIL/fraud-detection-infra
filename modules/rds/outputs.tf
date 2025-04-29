output "db_endpoint" {
  description = "The endpoint to connect to the RDS PostgreSQL instance"
  value       = aws_db_instance.fraud_db.endpoint
}

output "db_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}
