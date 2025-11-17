<h1 align="center">🚀 Terraform K8s Project</h1>
<p align="center">AWS EKS • Terraform Infrastructure • Web App + Auth API on Kubernetes</p>
<p align="center">CI/CD: ❌ Not Included • Deployment: Manual</p>

---

## 🔧 Overview
This repository contains infrastructure-as-code and Kubernetes manifests for running two applications on AWS EKS:
- A public **Web App**
- An internal **Auth API**

Infrastructure is provisioned with Terraform in the `terraform/` directory.  
Kubernetes workloads are defined in the `k8s/` directory.  
Docker images are pushed manually to AWS ECR.

---

## 🏗 Architecture
Docker Images (Web App + Auth API)  
⬇  
Amazon ECR  
⬇  
Terraform (AWS + EKS)  
⬇  
Amazon EKS Cluster  
⬇  
Kubernetes Deployments + Services  
⬇  
Web App ↔ Auth API (internal cluster communication)

---

## 📁 Repository Structure
Terraform-k8s-project/  
 ├── terraform/  
 │   ├── main.tf  
 │   ├── variables.tf  
 │   ├── outputs.tf  
 │   └── (EKS / networking / IAM resources)  
 ├── k8s/  
 │   ├── web_app-deployment.yaml  
 │   ├── web_app-service.yaml  
 │   ├── auth_api-deployment.yaml  
 │   ├── auth_api-service.yaml  
 │   └── namespace.yaml  
 └── README.md

---

## ☁️ AWS Infrastructure (Terraform)

### 🌐 Networking & Cluster
- VPC, subnets, routing  
- Security groups  
- EKS cluster  
- Node group(s)  
- IAM roles  

### 🐳 Amazon ECR
- ECR repo for **web_app**  
- ECR repo for **auth_api**

---

## 🚢 Kubernetes Workloads

### 📦 Deployments
- `web_app-deployment.yaml`  
- `auth_api-deployment.yaml`  
Each includes:
- ECR image
- Environment variables
- Replicas

### 🔌 Services
- `web_app-service.yaml` (ClusterIP / NodePort)  
- `auth_api-service.yaml` (ClusterIP)

### 🗂 Namespace
- `namespace.yaml` for isolation

---

## ▶️ Manual Deployment

### 1. Terraform AWS Infrastructure
cd terraform  
terraform init  
terraform plan  
terraform apply  

### 2. Build & Push Docker Images
docker build -t web_app .  
docker build -t auth_api .  
docker push <ECR>/web_app  
docker push <ECR>/auth_api  

### 3. Apply Kubernetes Manifests
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

## 🗺 Future Improvements
- Add GitHub Actions CI/CD  
- Add Ingress / ALB for external access  
- Add dev/stage/prod namespaces  
- Add ConfigMaps + Secrets  
- Automatic versioning and rollouts  
