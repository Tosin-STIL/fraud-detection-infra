output "repository_urls" {
  description = "URLs of the created ECR repositories"
  value = {
    ingestion_service        = aws_ecr_repository.ingestion_service.repository_url
    fraud_detection_service  = aws_ecr_repository.fraud_detection_service.repository_url
    action_service           = aws_ecr_repository.action_service.repository_url
  }
}
