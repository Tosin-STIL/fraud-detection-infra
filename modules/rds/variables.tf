variable "project_name" {
  description = "Project prefix (e.g., fraud-detection)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region (e.g., eu-west-1)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach the RDS security group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnets for the DB subnet group"
  type        = list(string)
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "fraudadmin"
}
