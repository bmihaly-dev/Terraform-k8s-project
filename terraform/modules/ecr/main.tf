resource "awsecrrepository" "this" {
  name                 = "${var.project_name}-ecr"
  imagetagmutability = "MUTABLE"
  force_delete         = true

  imagescanningconfiguration {
    scanonpush = true
  }

  tags = {
    Name = "${var.project_name}-ecr"
  }
}

resource "terraformdata" "pushimages" {
  dependson = [awsecr_repository.this]

  provisioner "local-exec" {
    command = <<EOT
      # Authenticate Docker with ECR using the specified AWS CLI profile
      docker logout
      aws ecr get-login-password --region ${var.region} --profile ${var.profile} | docker login --username AWS --password-stdin ${awsecrrepository.this.repository_url}

      # Build and push image (eks-demo-express)
      cd ../backend
      docker build -t eks-demo-express:latest .
      docker tag eks-demo-express:latest ${awsecrrepository.this.repository_url}:eks-demo-express
      docker push ${awsecrrepository.this.repository_url}:eks-demo-express

      # Build and push image (eks-demo-php)
      cd ../php
      docker build -t eks-demo-php:latest .
      docker tag eks-demo-php:latest ${awsecrrepository.this.repository_url}:eks-demo-php
      docker push ${awsecrrepository.this.repository_url}:eks-demo-php
    EOT
  }
}