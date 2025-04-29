# Create ECR repositories for microservices
resource "aws_ecr_repository" "ingestion_service" {
  name = "${var.project_name}-${var.environment}-ingestion-service"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "Ingestion Service Repo"
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "fraud_detection_service" {
  name = "${var.project_name}-${var.environment}-fraud-detection-service"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "Fraud Detection Service Repo"
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "action_service" {
  name = "${var.project_name}-${var.environment}-action-service"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "Action Service Repo"
    Environment = var.environment
  }
}
