# DevOps Project 
# Multi-Cloud Web Application

A production-ready two-tier web application demonstrating modern DevOps practices across AWS and GCP. Built with Python FastAPI, Next.js, and fully automated CI/CD pipelines.

![Architecture Diagram](https://github.com/user-attachments/assets/ecbfdc14-930b-4f2d-a9b5-18a53393fe9c)

## Live Demo

**Check it out:** https://devops-frontend-v5-743723559454.us-central1.run.app/

## What I Built

This project showcases a complete cloud-native application deployed to both AWS and GCP, with infrastructure as code, automated testing, and comprehensive monitoring. The application features a FastAPI backend and Next.js frontend, demonstrating my ability to work with modern cloud platforms and DevOps tooling.

## Tech Stack

**Frontend:** Next.js
**Backend:** Python, FastAPI, Uvicorn  
**Cloud Platforms:** AWS (ECS, ALB, CloudWatch, VPC, IAM), GCP (Cloud Run, Cloud Monitoring)  
**Infrastructure:** Terraform, Docker  
**CI/CD:** GitHub Actions  
**Testing:** Pytest, Jest

## Project Structure

```
.
├── backend/                    # FastAPI backend
│   ├── app/
│   │   ├── main.py            # API endpoints
│   │   └── test_main.py       # Unit tests
│   ├── Dockerfile             # Multi-stage Dockerfile
│   └── requirements.txt
├── frontend/                   # Next.js frontend
│   ├── pages/
│   │   └── index.js           # Main page with SSR
│   ├── __tests__/             # Jest tests
│   ├── Dockerfile             # Multi-stage Dockerfile
│   └── package.json
├── terraform/
│   ├── aws/                   # AWS infrastructure
│   │   ├── main.tf           # Provider & backend config
│   │   ├── vpc.tf            # VPC, subnets, routing
│   │   ├── ecs.tf            # ECS cluster & services
│   │   ├── alb.tf            # Load balancer
│   │   ├── iam.tf            # IAM roles
│   │   ├── secrets.tf        # Secrets Manager
│   │   ├── security.tf       # Security groups
│   │   └── monitoring.tf     # CloudWatch dashboards & alerts
│   └── gcp/                   # GCP infrastructure
│       ├── main.tf           # Provider config
│       ├── backend.tf        # GCS state backend
│       ├── cloudrun.tf       # Cloud Run services
│       ├── secrets.tf        # Secret Manager
│       └── monitoring.tf     # Cloud Monitoring
└── .github/
    └── workflows/
        ├── ci.yml            # CI pipeline (develop)
        └── cd.yml            # CD pipeline (main)
```

## Key Features

### Automated CI/CD
- **CI Pipeline** runs on every push to `develop` - executes unit tests for both frontend and backend, builds Docker images, and validates the build
- **CD Pipeline** deploys to production on merge to `main` - pushes images to container registries and provisions infrastructure via Terraform
- Zero-downtime deployments with automated rollbacks on failure

### Multi-Cloud Infrastructure
**AWS Deployment**
- ECS Fargate for serverless container orchestration
- Application Load Balancer for traffic distribution
- Multi-AZ deployment for high availability
- CloudWatch for metrics and alerting

**GCP Deployment**
- Cloud Run for fully managed container hosting
- Auto-scaling based on traffic patterns
- Built-in HTTPS and load balancing

### Security Best Practices
- Secrets stored in AWS Secrets Manager and GCP Secret Manager
- IAM roles following least-privilege principle
- Security groups limiting traffic to necessary ports only
- Container images built with multi-stage Dockerfiles to minimize attack surface

### Monitoring & Observability
- Custom CloudWatch dashboards tracking CPU and memory utilization
- GCP Cloud Monitoring for request latency and error rates
- Automated alerts for anomalous behavior (CPU threshold violations)
- Centralized logging for troubleshooting

### Resiliency
- Load balancing across multiple container instances
- Automatic health checks and container replacement
- Infrastructure spanning multiple availability zones
- Auto-scaling policies based on demand

## Development

Running the application locally:

```bash
# Backend
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload

# Frontend
cd frontend
npm install
npm run dev
```

Running tests:

```bash
# Backend tests
cd backend && pytest

# Frontend tests
cd frontend && npm test
```

## Infrastructure Management

All infrastructure is defined as code using Terraform. State files are stored remotely in S3 (AWS) and Google Cloud Storage (GCP) for team collaboration and disaster recovery.

```bash
cd terraform/aws
terraform init
terraform plan
terraform apply

cd ../gcp
terraform init
terraform plan
terraform apply
```

Thanks for reading, drop a star if you feel like it😗
