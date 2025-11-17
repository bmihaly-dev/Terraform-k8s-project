<h1 align="center">🚀 Terraform K8s Project</h1>
<p align="center">AWS EKS • Terraform Infrastructure • Web App + Auth API on Kubernetes</p>
<p align="center">CI/CD: ❌ Not Included • Deployment: Manual</p>

---

## 🔧 Overview
This project provisions a full Kubernetes environment on AWS using Terraform, deploying two applications:
- A public **Web App**
- An internal **Auth API**

Both services run inside the Kubernetes cluster and communicate via ClusterIP Services.  
Docker images are stored in AWS ECR and deployed manually to EKS.

---

## 🏗 Architecture
Docker Images (WebApp + AuthAPI)  
↓  
Amazon ECR  
↓  
Terraform  
↓  
Amazon EKS Cluster  
↓  
Kubernetes Deployments + Services  
↓  
Web App ↔ Auth API internal communication

---

## 📁 Repository Structure
Terraform-k8s-project/  
 ├── infrastructure/  
 │   ├── eks/  
 │   │   ├── main.tf  
 │   │   ├── variables.tf  
 │   │   ├── outputs.tf  
 │   │   └── eks.tf  
 │   ├── ecr/  
 │   │   └── main.tf  
 │   ├── networking/  
 │   │   ├── vpc.tf  
 │   │   ├── subnets.tf  
 │   │   ├── igw.tf  
 │   │   └── route_tables.tf  
 ├── k8s/  
 │   ├── web_app-deployment.yaml  
 │   ├── web_app-service.yaml  
 │   ├── auth_api-deployment.yaml  
 │   ├── auth_api-service.yaml  
 │   └── namespace.yaml  
 ├── docker/  
 │   ├── web_app/  
 │   │   └── Dockerfile  
 │   ├── auth_api/  
 │   │   └── Dockerfile  
 └── README.md

---

## ☁️ AWS Infrastructure Components

### 🌐 VPC & Networking
- Custom VPC  
- Public & private subnets  
- Internet Gateway  
- Route tables  
- Security groups for EKS nodes  

### 🐳 ECR (Elastic Container Registry)
- Repository for **web_app**  
- Repository for **auth_api**

### 🎛 Amazon EKS
- Managed Kubernetes control plane  
- Node group for workloads  
- IAM roles for EKS & worker nodes  
- OIDC provider (optional, not used here)

---

## 🚢 Kubernetes Components

### 📦 Deployments
- `web_app` deployment  
- `auth_api` deployment  
Both configured with:
- Replicas  
- Container images from ECR  
- Environment variables (e.g., `IP_START`)  
- Resource requests/limits (optional)

### 🔌 Services
- `web_app-service` (ClusterIP / NodePort depending on config)  
- `auth_api-service` (ClusterIP)  

### 🗂 Namespace
- Custom namespace for project isolation

---

## ▶️ Deployment Process (Manual)
1. Build Docker images  
2. Push to ECR  
3. Apply Terraform  
4. Update K8s manifests with the latest image tags  
5. Deploy to cluster:
