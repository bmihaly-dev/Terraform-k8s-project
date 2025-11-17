output "ecrwebapp_uri" {
  value       = local.webappuri
  description = "web-app ECR image URI (repo:tag)"
}

output "ecrauthapi_uri" {
  value       = local.authapiuri
  description = "auth-api ECR image URI (repo:tag)"
}

output "ingress_hint" {
  value       = "Futás után: kubectl get ingress -n ${var.namespace} " ALB DNS"
  description = "Hol találod az ALB hostnevet
}