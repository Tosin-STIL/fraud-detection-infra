# --- Load DB Password Securely from SSM Parameter Store ---
data "aws_ssm_parameter" "db_password" {
  name            = "/fraud-detection/dev/db_password"
  with_decryption = true
}

# --- RDS Subnet Group ---
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-subnet-group"
    Environment = var.environment
  }
}

# --- Security Group for RDS ---
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ❗ Replace with trusted CIDR in production
    description = "Allow PostgreSQL access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Environment = var.environment
  }
}

# --- RDS PostgreSQL Instance ---
resource "aws_db_instance" "fraud_db" {
  identifier              = "${var.project_name}-${var.environment}-fraud-db"
  engine                  = "postgres"
  engine_version          = "14.17"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  username                = var.db_username
  password                = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  backup_retention_period = 1
  skip_final_snapshot     = true
  storage_encrypted       = true
  multi_az                = false
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-fraud-db"
    Environment = var.environment
  }
}
