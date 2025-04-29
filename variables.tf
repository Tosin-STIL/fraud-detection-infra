variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "fraud-detection"
}

variable "environment" {
  description = "Environment to deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
}
