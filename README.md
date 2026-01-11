# DevOps Assignment - Multi-Cloud Deployment

A production-ready two-tier web application (Python FastAPI backend + Next.js frontend) deployed to **AWS** and **GCP** with full CI/CD automation, monitoring, and security.

---

## 🏗️ Architecture Overview

<p align="center">
  <img src="https://github.com/user-attachments/assets/ecbfdc14-930b-4f2d-a9b5-18a53393fe9c" width="800" />
</p>

---
## 🌐 Live URLs

### AWS
| Service | URL |
|---------|-----|
| Frontend | http://devops-alb-v2-1840220508.us-east-2.elb.amazonaws.com |
| Backend API | http://devops-alb-v2-1840220508.us-east-2.elb.amazonaws.com/api/health |

### GCP
| Service | URL |
|---------|-----|
| Frontend | https://devops-frontend-v5-743723559454.us-central1.run.app/ |
| Backend API | https://devops-backend-v5-743723559454.us-central1.run.app/ |

---

## 📁 Project Structure

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

---

## 🚀 CI/CD Pipeline

### CI Pipeline (`ci.yml`) - Triggers on `develop` branch
1. ✅ Checkout code
2. ✅ Run backend tests (pytest)
3. ✅ Run frontend tests (Jest)
4. ✅ Build Docker images
5. ✅ Tag with Git SHA

### CD Pipeline (`cd.yml`) - Triggers on `main` branch
1. ✅ Build & push images to ECR (AWS) and Artifact Registry (GCP)
2. ✅ Run Terraform to deploy AWS infrastructure
3. ✅ Run Terraform to deploy GCP infrastructure
4. ✅ Zero manual steps

### Git Workflow
```
feature/* → develop (CI runs) → PR to main → main (CD deploys)
```

---

## 🛠️ Local Development

### Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: .\venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

### Run Tests
```bash
# Backend tests
cd backend && pytest

# Frontend tests
cd frontend && npm test
```

---

## 🔐 Security

### Secrets Management
| Platform | Service | Secrets Stored |
|----------|---------|----------------|
| AWS | Secrets Manager | `devops-app-secret-v2` |
| GCP | Secret Manager | `devops-app-secret-v5` |
| CI/CD | GitHub Secrets | All credentials |

### IAM Roles (Least Privilege)
- **AWS**: `devops-ecs-execution-role-v2`, `devops-ecs-task-role-v2`
- **GCP**: Cloud Run service accounts

### Network Security
| Resource | Ingress | Egress |
|----------|---------|--------|
| AWS ALB | Port 80 (public) | All |
| AWS ECS Tasks | Port 8000, 3000 (from ALB only) | All |
| GCP Cloud Run | HTTPS (public) | All |

---

## 📊 Monitoring & Alerting

### Dashboards
- **AWS**: CloudWatch Dashboard (`devops-assignment-dashboard`)
  - CPU Utilization
  - Memory Utilization
- **GCP**: Cloud Monitoring Dashboard
  - Request count/latency
  - Container metrics

### Alerts Configured
| Alert | Condition | Notification |
|-------|-----------|--------------|
| High CPU (AWS) | CPU > 70% for 5 min | SNS → Email |

---

## ⚖️ Load Balancing & Resiliency

### AWS
- **ALB** distributes traffic across 2 ECS tasks per service
- **Fargate** automatically replaces unhealthy containers
- **Multi-AZ** deployment (us-east-2a, us-east-2b)

### GCP
- **Cloud Run** auto-scales based on traffic
- Built-in load balancing

### Testing Resiliency
1. Stop one ECS task via AWS Console
2. Verify application remains accessible
3. Observe new task automatically starting

---

## 📦 Terraform State

| Cloud | Backend | Bucket |
|-------|---------|--------|
| AWS | S3 | `devops-assignment-tf-state-aws` |
| GCP | GCS | `devops-assignment-tf-state` |

---

## 📋 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Backend health message |
| `/api/health` | GET | Health check |
| `/api/message` | GET | Integration message |

---

## ✅ Assignment Checklist

- [x] Version Control (main/develop branching)
- [x] Backend with tests (pytest)
- [x] Frontend with tests (Jest)
- [x] Multi-stage Dockerfiles
- [x] CI/CD with GitHub Actions
- [x] Deployed to AWS (ECS + ALB)
- [x] Deployed to GCP (Cloud Run)
- [x] Terraform for all infrastructure
- [x] Monitoring dashboards
- [x] CPU alert configured
- [x] Secrets in Secrets Manager
- [x] Least-privilege IAM roles
- [x] Load balancing (2+ instances)
- [x] README documentation

---

Thank you!
