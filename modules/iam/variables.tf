variable "project_name" {
  description = "Name of the project (e.g., fraud-detection)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "aws_account_id" {
  description = "Your AWS Account ID"
  type        = string
}
