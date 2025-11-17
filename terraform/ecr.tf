data "awscalleridentity" "current" {}

# ECR repo-k
resource "awsecrrepository" "web_app" {
  name                 = "web-app"
  imagetagmutability = "IMMUTABLE"
  force_delete         = true
  imagescanningconfiguration { scanonpush = true }
  encryptionconfiguration { encryptiontype = "AES256" }
}

resource "awsecrrepository" "auth_api" {
  name                 = "auth-api"
  imagetagmutability = "IMMUTABLE"
  force_delete         = true
  imagescanningconfiguration { scanonpush = true }
  encryptionconfiguration { encryptiontype = "AES256" }
}

# Opcionális: életciklus (tartsd meg az utolsó 10 képet)
resource "awsecrlifecyclepolicy" "webapp" {
  repository = awsecrrepository.web_app.name
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

resource "awsecrlifecyclepolicy" "authapi" {
  repository = awsecrrepository.auth_api.name
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
  accountid   = data.awscalleridentity.current.accountid
  ecrdomain   = "${local.accountid}.dkr.ecr.${var.region}.amazonaws.com"
  webappuri  = "${local.ecrdomain}/${awsecrrepository.webapp.name}:${var.webapptag}"
  authapiuri = "${local.ecrdomain}/${awsecrrepository.authapi.name}:${var.authapitag}"
}