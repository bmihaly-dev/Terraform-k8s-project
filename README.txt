<h1 align="center">🚀 Terraform K8s Project</h1>
<p align="center">AWS EKS • Terraform • Kubernetes • Web App + Auth API</p>
<p align="center">Infrastructure: ✅ Complete • CI/CD: ❌ Not Implemented</p>

---

<h2>🔧 Overview</h2>
This project provisions AWS infrastructure using Terraform and deploys two applications into an EKS cluster:

- 🌐 <strong>Web App</strong> – public-facing
- 🔐 <strong>Auth API</strong> – internal backend

Docker images are built locally, pushed manually to AWS ECR, and deployed into the EKS cluster using Kubernetes manifests.

---

<h2>🏗 Architecture</h2>

```
Docker Images → AWS ECR
        ↓
Terraform → AWS VPC + IAM + EKS
        ↓
Amazon EKS Cluster
        ↓
Kubernetes Deployments + Services
        ↓
Web App ↔ Auth API (internal communication)
```

---

<h2>📁 Repository Structure</h2>

```
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
```

---

<h2>☁️ AWS Infrastructure (Terraform)</h2>

<h3>🌐 Networking</h3>
- Custom VPC  
- Public & private subnets  
- Route tables  
- Security groups  

<h3>🎛 EKS Cluster</h3>
- Managed Kubernetes control plane  
- Worker node groups  
- IAM roles  

<h3>🐳 ECR Repositories</h3>
- web_app  
- auth_api  

---

<h2>🚢 Kubernetes Workloads</h2>

<h3>📦 Deployments</h3>
- web_app-deployment.yaml  
- auth_api-deployment.yaml  
Includes:
- replicas  
- environment variables  
- ECR image reference  

<h3>🔌 Services</h3>
- web_app-service.yaml (ClusterIP / NodePort)  
- auth_api-service.yaml (ClusterIP)  

<h3>🗂 Namespace</h3>
- namespace.yaml  

---

<h2>▶️ Manual Deployment</h2>

<h3>1️⃣ Deploy AWS Infrastructure</h3>
cd terraform  
terraform init  
terraform plan  
terraform apply  

<h3>2️⃣ Build & Push Docker Images</h3>
docker build -t web_app ./web_app  
docker tag web_app <ECR_URI>/web_app:latest  
docker push <ECR_URI>/web_app:latest  

docker build -t auth_api ./auth_api  
docker tag auth_api <ECR_URI>/auth_api:latest  
docker push <ECR_URI>/auth_api:latest  

<h3>3️⃣ Deploy to Kubernetes</h3>
cd k8s  
kubectl apply -f namespace.yaml  
kubectl apply -f auth_api-deployment.yaml  
kubectl apply -f auth_api-service.yaml  
kubectl apply -f web_app-deployment.yaml  
kubectl apply -f web_app-service.yaml  

---

<h2>🗺 Future Improvements</h2>
- Add GitHub Actions / Jenkins CI/CD  
- Add ALB Ingress  
- Add K8s Secrets & ConfigMaps  
- Add autoscaling (HPA)  
- Add multiple environments (dev/stage/prod)  