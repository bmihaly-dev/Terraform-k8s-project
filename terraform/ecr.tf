data "aws_caller_identity" "current" {}

# ECR repo-k
resource "aws_ecr_repository" "web_app" {
  name                 = "web-app"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
  image_scanning_configuration { scan_on_push = true }
  encryption_configuration { encryption_type = "AES256" }
}

resource "aws_ecr_repository" "auth_api" {
  name                 = "auth-api"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
  image_scanning_configuration { scan_on_push = true }
  encryption_configuration { encryption_type = "AES256" }
}

# Opcionális: életciklus (tartsd meg az utolsó 10 képet)
resource "aws_ecr_lifecycle_policy" "web_app" {
  repository = aws_ecr_repository.web_app.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}

resource "aws_ecr_lifecycle_policy" "auth_api" {
  repository = aws_ecr_repository.auth_api.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}


locals {
  account_id   = data.aws_caller_identity.current.account_id
  ecr_domain   = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  web_app_uri  = "${local.ecr_domain}/${aws_ecr_repository.web_app.name}:${var.web_app_tag}"
  auth_api_uri = "${local.ecr_domain}/${aws_ecr_repository.auth_api.name}:${var.auth_api_tag}"
}