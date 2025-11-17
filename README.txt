<h1 align="center">🚀 Terraform–Kubernetes Project</h1>
<p align="center">AWS EKS • Terraform Infrastructure • Kubernetes Web App + Auth API</p>
<p align="center">Infrastructure: ✅ Complete • CI/CD: ❌ Not Implemented</p>

---

## 🔧 Overview
This project provisions a full AWS-based Kubernetes infrastructure using Terraform.  
It includes an Amazon EKS cluster, AWS ECR repositories, IAM roles, VPC networking, and manual Kubernetes deployments for two services: Web App and Auth API.

---

## 🏗 Architecture
Docker Images → AWS ECR  
↓  
Terraform → VPC + IAM + EKS  
↓  
Amazon EKS Cluster  
↓  
Kubernetes Deployments + Services  
↓  
Web App ↔ Auth API (internal communication)

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

### 🪣 ECR Repositories
- web_app container repository  
- auth_api container repository  
- Supports manual tagging & pushing  

### 🌐 VPC & Networking
- Custom VPC  
- Public/private subnets  
- Routing tables  
- Security groups  

### 🎛 EKS Cluster
- Managed control plane  
- Node groups  
- IAM roles for nodes and cluster  

---

## 🚢 Kubernetes Components

### 📦 Deployments
- web_app-deployment.yaml  
- auth_api-deployment.yaml  
Includes:
- replicas  
- environment variables  
- image from ECR  
- restart policy  

### 🔌 Services
- web_app-service.yaml (ClusterIP / NodePort)  
- auth_api-service.yaml (ClusterIP)  

### 🗂 Namespace
- namespace.yaml for isolation  

---

## 🛠 Deployment Workflow (Manual)

### ✔ Completed
- Terraform infrastructure ready  
- EKS cluster working  
- kubectl configured  
- Images can be pushed to ECR  
- Manifests correctly apply & run  

### ❌ Still Manual (No CI/CD)
- No pipeline  
- No automated apply  
- No auto-image updates  

---

## ▶️ Setup

### 1. Terraform Infrastructure
cd terraform  
terraform init  
terraform validate  
terraform plan  
terraform apply  

### 2. Build & Push Docker Images
docker build -t web_app ./web_app  
docker tag web_app <ECR_URI>/web_app:latest  
docker push <ECR_URI>/web_app:latest  

docker build -t auth_api ./auth_api  
docker tag auth_api <ECR_URI>/auth_api:latest  
docker push <ECR_URI>/auth_api:latest  

### 3. Kubernetes Deployment
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

## 🗺 Roadmap
- Add CI/CD pipeline (GitHub Actions or Jenkins)  
- Add AWS ALB ingress with HTTPS  
- Add secrets & configmaps  
- Implement autoscaling (HPA)  
- Add multi-environment support (dev/stage/prod)  
