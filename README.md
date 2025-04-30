# Fraud Detection Infrastructure (Terraform)

## Project Overview
This repository, **fraud-detection-infra**, provisions the cloud-native infrastructure required for deploying a real-time fraud detection system tailored for banking and financial services. The application is built using a microservices architecture and orchestrated on AWS using ECS Fargate, with supporting services including Amazon ECR, Kinesis, RDS, IAM, SNS, and CloudWatch.

This infrastructure-as-code (IaC) implementation uses **Terraform** to ensure modular, version-controlled, and reproducible deployments.

GitHub Actions is integrated for CI/CD automation, and observability is achieved through Amazon CloudWatch and SNS-based fraud alerting.

---

## Technologies Used
- **Terraform**
- **AWS ECS (Fargate)**
- **AWS ECR**
- **Amazon RDS (PostgreSQL)**
- **Amazon Kinesis**
- **AWS CloudWatch**
- **AWS IAM & KMS**
- **Amazon SNS**
- **GitHub Actions**

---

## Phase 1: Local Setup
### 1.1 Prerequisites
Install the following tools:
- AWS CLI
- Terraform >= 1.0.0
- Docker Desktop
- Python 3.11+
- Git
- VS Code

### 1.2 AWS Configuration
- Configure AWS CLI with Administrator credentials
- Region used: `eu-west-1`

### 1.3 Repositories
- `fraud-detection-infra` (this repo)
- `fraud-detection-app` (application microservices)

---

## Phase 2: Infrastructure Provisioning

### 2.1 Backend Setup (State Management)
Create an S3 bucket and DynamoDB table to store and lock Terraform state:
```bash
cd fraud-detection-infra/backend/
terraform init
terraform apply
```

### 2.2 Terraform Root Files
Create root-level Terraform configuration:
```hcl
# provider.tf
provider "aws" {
  region = "eu-west-1"
}

# main.tf (with module blocks)
module "vpc"     { source = "./modules/vpc" ... }
module "ecr"     { source = "./modules/ecr" ... }
module "kinesis" { source = "./modules/kinesis" ... }
module "ecs"     { source = "./modules/ecs" ... }
module "rds"     { source = "./modules/rds" ... }
module "iam"     { source = "./modules/iam" ... }
```

### 2.3 Terraform Modules
Each module is located under `modules/<module-name>/` and has:
- `main.tf`
- `variables.tf`
- `outputs.tf`

#### VPC Module
Provisions a secure, multi-AZ VPC with public/private subnets, IGW, and NAT Gateway.

#### ECR Module
Creates three ECR repositories:
- ingestion-service
- fraud-detection-service
- action-service

#### ECS Module
Creates an ECS Fargate cluster and execution IAM role.

#### RDS Module
Deploys PostgreSQL for compliance and fraud audit logging.

#### IAM Module
Creates service roles with least privilege policies for ECS and supporting services.

#### Kinesis Module
Creates a Kinesis Data Stream for real-time transaction ingestion.

### 2.4 .gitignore and .terraformignore
Add to root and module directories respectively:
```gitignore
.terraform/
*.tfstate*
*.tfplan
*.pem
*.auto.tfvars
```

---

## Phase 3: Application Services (See `fraud-detection-app`)
Application services are deployed from a separate repo:
- ingestion_service
- fraud_detection_service
- action_service

All are containerized, FastAPI-based, and trained on a custom ML model.

---

## Phase 4: GitHub Actions CI/CD
CI/CD pipeline for microservices is defined in `.github/workflows/deploy.yml` of the app repo.

### Features:
- Build and push Docker images to ECR
- Register ECS task definitions
- Update ECS services
- Injects logging configuration for CloudWatch

### Required GitHub Secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

---

## Phase 5: Monitoring & Alerting

### 5.1 CloudWatch Logs
Enabled via ECS task definition logging configuration. Log groups are named:
- `/ecs/fraud-detection-dev-ingestion-service`
- `/ecs/fraud-detection-dev-fraud-detection-service`
- `/ecs/fraud-detection-dev-action-service`

### 5.2 CloudWatch Container Insights
Enable in ECS Console to collect resource metrics (CPU, memory, network).

### 5.3 SNS Fraud Alerting
- SNS Topic: `arn:aws:sns:eu-west-1:590183956481:fraud-alerts`
- Subscribed email addresses receive alerts on high-confidence fraud.

---

## Post-Deployment Recommendations

### ✅ Store Audit Logs in RDS
Log flagged transactions in PostgreSQL via action_service.
```sql
CREATE TABLE audit_log (
  id SERIAL PRIMARY KEY,
  transaction_id VARCHAR,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR,
  details JSONB
);
```

### ✅ Secure Secrets
Use AWS SSM Parameter Store for storing:
- DB credentials
- API keys
- Service configs

### ✅ ECS Exec for Debugging
Enable ECS Exec for real-time container access (no SSH required).

---

## Final Notes
- This repository handles **only infrastructure provisioning**.
- Microservices development and deployment logic reside in [`fraud-detection-app`](https://github.com/Tosin-STIL/fraud-detection-app).
- Deploy infrastructure **before** triggering CI/CD workflows.

---

## License
This project is open-source and licensed under the MIT License.

## Maintainer
**Oluwatosin Jegede**  
Cloud Solutions Architect | DevOps Engineer  
[GitHub](https://github.com/Tosin-STIL) | [LinkedIn](https://www.linkedin.com/in/oluwatosin-jegede/)

