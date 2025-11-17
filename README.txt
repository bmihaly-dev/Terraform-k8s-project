# 🚀 Terraform K8s Project
Modern AWS EKS infrastructure with Terraform · Web App + Auth API deployed to Kubernetes  
Infrastructure COMPLETE · CI/CD NOT included

## 🔧 Overview
This project contains a full AWS + Kubernetes environment built with Terraform.  
It deploys two applications into an EKS cluster:

- 🌐 Web App (public-facing)
- 🔐 Auth API (internal backend)

Docker images are stored in AWS ECR.  
Terraform builds all AWS infrastructure.  
Kubernetes manifests deploy both applications.

---

## 🏗 Architecture
Docker Images (Web App + Auth API)  
        ↓  
AWS ECR  
        ↓  
Terraform (VPC + IAM + EKS)  
        ↓  
Amazon EKS Cluster  
        ↓  
Kubernetes Deployments + Services  
        ↓  
Web App ↔ Auth API (internal communication)

---

## 📁 Repository Structure
Terraform-k8s-project/  
 ├── terraform/  
 │   ├── main.tf  
 │   ├── variables.tf  
 │   ├── outputs.tf  
 │   └── (EKS / VPC / IAM resources)  
 ├── k8s/  
 │   ├── namespace.yaml  
 │   ├── web_app-deployment.yaml  
 │   ├── web_app-service.yaml  
 │   ├── auth_api-deployment.yaml  
 │   ├── auth_api-service.yaml  
 └── README.md

---

## ☁️ AWS Components

### 🌐 Networking
- VPC  
- Public + private subnets  
- Routing  
- Security groups  

### 🎛 EKS Cluster
- Managed Kubernetes control plane  
- Node groups  
- IAM roles for worker nodes  

### 🐳 ECR Repositories
- web_app container image repo  
- auth_api container image repo  

---

## 🚢 Kubernetes Components

### 📦 Deployments
- web_app-deployment.yaml  
- auth_api-deployment.yaml  
Each includes:
- ECR image  
- replicas  
- env vars  
- restart policy  

### 🔌 Services
- web_app-service.yaml (ClusterIP / NodePort)  
- auth_api-service.yaml (ClusterIP)

### 🗂 Namespace
- namespace.yaml → isolates workloads

---

## ▶️ Manual Deployment

### 1. Terraform AWS Infrastructure
cd terraform  
terraform init  
terraform plan  
terraform apply  

### 2. Build & Push Images to ECR
docker build -t web_app .  
docker tag web_app <ECR_URI>:latest  
docker push <ECR_URI>:latest  

(same for auth_api)

### 3. Deploy Kubernetes Manifests
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

## 🗺 Roadmap
- Add CI/CD pipeline (GitHub Actions / Jenkins)  
- Add Ingress + AWS ALB  
- Add Secrets + ConfigMaps  
- Autoscaling  
- Multi-env support  
