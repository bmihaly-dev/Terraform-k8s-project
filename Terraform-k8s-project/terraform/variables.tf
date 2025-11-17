variable "region" {
  description = "Region for the provider"
  type        = string
  default     = "eu-central-1"
}


variable "project_name" {
  description = "This value will be used as a tag for the related AWS resources!"
  type        = string
}
variable "namespace" {
  type        = string
  default     = "app"
  description = "K8s namespace az alkalmazásoknak"
}
variable "web_app_tag" {
  type        = string
  default     = "1.0.0"
  description = "web-app image tag"
}

variable "auth_api_tag" {
  type        = string
  default     = "1.0.0"
  description = "auth-api image tag"
}