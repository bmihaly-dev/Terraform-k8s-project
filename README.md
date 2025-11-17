<h1 align="center">🚀 Terraform–Kubernetes Project</h1>
<p align="center">AWS EKS • Terraform Infrastructure • Kubernetes Web App + Auth API</p>
<p align="center">Infrastructure: ✅ Complete • CI/CD: ❌ Not Implemented</p>

---

## 🔧 Overview
This project provisions a full AWS-based Kubernetes infrastructure using Terraform.  
It creates an Amazon EKS cluster, networking, IAM roles and ECR repositories, and deploys two services into the cluster:

- 🌐 **Web App** – public-facing application  
- 🔐 **Auth API** – internal backend service  

Docker images are built locally, pushed to AWS ECR, and deployed using Kubernetes manifests in the `k8s/` folder.

---

## 🏗 Architecture
Terraform → VPC + IAM + EKS  
↓  
Amazon EKS Cluster  
↓  
Kubernetes Deployments + Services  
↓  
Web App ↔ Auth API (internal communication via Service DNS)

---

## 📁 Repository Structure
terraform-k8s-project/  
 ├── terraform/  
 │   ├── main.tf  
 │   ├── variables.tf  
 │   ├── outputs.tf  
 │   └── (EKS / VPC / IAM modules)  
 ├── k8s/  
 │   ├── namespace.yaml  
 │   ├── web_app-deployment.yaml  
 │   ├── web_app-service.yaml  
 │   ├── auth_api-deployment.yaml  
 │   ├── auth_api-service.yaml  
 └── README.md  

---

## ☁️ AWS Components

### 🌐 VPC & Networking
- Custom VPC  
- Public/private subnets  
- Route tables  
- Security groups  

### 🎛 EKS Cluster
- Managed Kubernetes control plane (Amazon EKS)  
- Worker node groups  
- IAM roles for cluster and nodes  

### 🐳 ECR Repositories
- `web_app` image repository  
- `auth_api` image repository  

---

## 🚢 Kubernetes Components

### 📦 Deployments
- `web_app-deployment.yaml`  
- `auth_api-deployment.yaml`  

Each deployment defines:
- container image from ECR  
- number of replicas  
- environment variables  
- restart policy  

### 🔌 Services
- `web_app-service.yaml` – exposes the Web App (ClusterIP / NodePort)  
- `auth_api-service.yaml` – internal ClusterIP Service for the Auth API  

### 🗂 Namespace
- `namespace.yaml` – isolates all resources in a dedicated namespace  

---

## ▶️ Manual Deployment

### 1. Provision AWS Infrastructure (Terraform)
cd terraform  
terraform init  
terraform plan  
terraform apply  

### 2. Build & Push Docker Images to ECR
# Web App  
docker build -t web_app ./web_app  
docker tag web_app <ECR_WEB_APP_URI>:latest  
docker push <ECR_WEB_APP_URI>:latest  

# Auth API  
docker build -t auth_api ./auth_api  
docker tag auth_api <ECR_AUTH_API_URI>:latest  
docker push <ECR_AUTH_API_URI>:latest  

### 3. Deploy to Kubernetes (EKS)
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

## 🗺 Roadmap
- Add CI/CD (GitHub Actions / Jenkins) for build + deploy  
- Add Ingress + AWS ALB for external access  
- Use ConfigMaps & Secrets for configuration and sensitive data  
- Add autoscaling (HPA) for both services  
- Add multiple environments (dev / stage / prod)  
