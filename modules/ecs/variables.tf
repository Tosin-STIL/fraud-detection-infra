variable "project_name" {
  description = "Project name to prefix repository names"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}
