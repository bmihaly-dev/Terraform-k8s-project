output "ecr_web_app_uri" {
  value       = local.web_app_uri
  description = "web-app ECR image URI (repo:tag)"
}

output "ecr_auth_api_uri" {
  value       = local.auth_api_uri
  description = "auth-api ECR image URI (repo:tag)"
}

output "ingress_hint" {
  value       = "Futás után: kubectl get ingress -n ${var.namespace} → ALB DNS"
  description = "Hol találod az ALB hostnevet"
}