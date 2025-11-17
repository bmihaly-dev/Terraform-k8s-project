# 🚀 Terraform K8s Project
Modern AWS EKS infrastructure with Terraform and Kubernetes deployments for Web App and Auth API.

CI/CD: ❌ Not Included  
Deployments: Manual  
Registry: AWS ECR  
Cluster: Amazon EKS

---

## 🔧 Overview
This project provisions AWS infrastructure using Terraform and deploys two applications into an EKS Kubernetes cluster:

- 🌐 **Web App** – public-facing  
- 🔐 **Auth API** – internal backend

Containers are pushed to **AWS ECR**, Terraform provisions EKS + networking, Kubernetes manifests deploy the workloads.

---

## 🏗 Architecture
Docker Images → AWS ECR  
⬇  
Terraform → AWS VPC + IAM + EKS  
⬇  
Kubernetes Deployments + Services  
⬇  
Web App ↔ Auth API (internal communication)

---

## 📁 Repository Structure
Terraform-k8s-project/  
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

## ☁️ AWS Infrastructure (Terraform)

### 🌐 Networking
- Custom VPC  
- Public & private subnets  
- Route tables  
- Security groups  

### 🎛 EKS Cluster
- Managed Kubernetes control plane  
- Worker node groups  
- IAM roles for nodes and cluster  

### 🐳 ECR Repositories
- `web_app` image repo  
- `auth_api` image repo  

---

## 🚢 Kubernetes Workloads

### 📦 Deployments
- `web_app-deployment.yaml`  
- `auth_api-deployment.yaml`  

Each deployment uses:
- ECR container image  
- Replicas  
- Environment variables  
- Resource configs (optional)

### 🔌 Services
- `web_app-service.yaml` → ClusterIP / NodePort  
- `auth_api-service.yaml` → ClusterIP  

### 🗂 Namespace
- `namespace.yaml` → workload isolation

---

## ▶️ Manual Deployment Steps

### 1️⃣ Deploy AWS Infrastructure
cd terraform  
terraform init  
terraform plan  
terraform apply  

### 2️⃣ Build & Push Images to ECR
docker build -t web_app .  
docker tag web_app <ECR_URI>:latest  
docker push <ECR_URI>:latest  

(same steps for **auth_api**)

### 3️⃣ Apply Kubernetes Manifests
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

## 🗺 Future Enhancements
- Add GitHub Actions / Jenkins CI/CD  
- Add Ingress + AWS ALB  
- Add Secrets + ConfigMaps  
- Autoscaling (HPA)  
- Multi-environment support (dev/stage/prod)  
