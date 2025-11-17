output "ecrwebapp_uri" {
  value       = local.webappuri
  description = "web-app ECR image URI (repo:tag)"
}

output "ecrauthapi_uri" {
  value       = local.authapiuri
  description = "auth-api ECR image URI (repo:tag)"
}

output "ingress_hint" {
  value       = "Fut√°s ut√°n: kubectl get ingress -n ${var.namespace} "Üí ALB DNS"
  description = "Hol tal√°lod az ALB hostnevet"
}