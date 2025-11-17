# 🚀 Terraform K8s Project
Modern AWS EKS infrastructure with Terraform and Kubernetes workloads (Web App + Auth API).

CI/CD: ❌ Not included  
Deployment: manual  
Registry: AWS ECR  
Cluster: Amazon EKS

---

## 🔧 Overview
This repository contains infrastructure-as-code and Kubernetes manifests for running two applications on AWS EKS:

- 🌐 Web App – public-facing frontend  
- 🔐 Auth API – internal backend service  

Infrastructure is provisioned with Terraform in the `terraform/` folder.  
Kubernetes workloads are defined as YAML manifests in the `k8s/` folder.  
Docker images are pushed manually to AWS ECR and then deployed to EKS.

---

## 🏗 Architecture

Docker Images (Web App + Auth API)  
        ↓  
AWS ECR (image registry)  
        ↓  
Terraform (VPC + IAM + EKS)  
        ↓  
Amazon EKS Cluster  
        ↓  
Kubernetes Deployments + Services  
        ↓  
Web App ↔ Auth API (internal cluster communication)

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

## ☁️ AWS Infrastructure (Terraform)

### 🌐 Networking
- Custom VPC  
- Public and/or private subnets  
- Route tables  
- Security groups  

### 🎛 EKS Cluster
- Managed Kubernetes control plane (Amazon EKS)  
- Worker node group(s)  
- IAM roles for cluster and nodes  

### 🐳 ECR Repositories
- ECR repository for `web_app` image  
- ECR repository for `auth_api` image  

---

## 🚢 Kubernetes Workloads (k8s/)

### 📦 Deployments
- `web_app-deployment.yaml`  
  - Uses image from ECR  
  - Runs the public-facing frontend  
  - Can be configured with environment variables (e.g. API URL, IP ranges, etc.)

- `auth_api-deployment.yaml`  
  - Uses image from ECR  
  - Exposes authentication / backend APIs  
  - Only reachable inside the cluster via Service DNS  

### 🔌 Services
- `web_app-service.yaml`  
  - Exposes the Web App (ClusterIP or NodePort depending on config)

- `auth_api-service.yaml`  
  - ClusterIP service for the Auth API  
  - Web App communicates with it via internal DNS name  

### 🗂 Namespace
- `namespace.yaml`  
  - Creates a dedicated Kubernetes namespace for this project  

---

## ▶️ Manual Deployment

### 1️⃣ Provision AWS Infrastructure with Terraform

From the `terraform/` folder:

    cd terraform
    terraform init
    terraform plan
    terraform apply

This will create the VPC, IAM roles, EKS cluster and related resources.

### 2️⃣ Build and Push Docker Images to ECR

Example (pseudo-steps, adjust to your real ECR URIs):

    # Build images
    docker build -t web_app ./path-to-web-app
    docker build -t auth_api ./path-to-auth-api

    # Tag with your ECR repos
    docker tag web_app <YOUR_ECR_WEB_APP_URI>:latest
    docker tag auth_api <YOUR_ECR_AUTH_API_URI>:latest

    # Push
    docker push <YOUR_ECR_WEB_APP_URI>:latest
    docker push <YOUR_ECR_AUTH_API_URI>:latest

Update the image fields in the deployment YAMLs if you are using versioned tags.

### 3️⃣ Apply Kubernetes Manifests to EKS

Assuming `kubectl` is configured against the EKS cluster:

    cd k8s
    kubectl apply -f namespace.yaml
    kubectl apply -f auth_api-deployment.yaml
    kubectl apply -f auth_api-service.yaml
    kubectl apply -f web_app-deployment.yaml
    kubectl apply -f web_app-service.yaml

---

## 🗺 Future Improvements

- Add GitHub Actions or Jenkins CI/CD:
  - Build & push Docker images to ECR
  - Apply Terraform and K8s manifests automatically  
- Introduce Ingress + AWS ALB for external access to Web App  
- Separate environments (dev / stage / prod) with multiple namespaces and/or Terraform workspaces  
- Use ConfigMaps and Secrets for configuration and sensitive data  
- Add autoscaling (HPA) and resource limits/requests for both deployments  
