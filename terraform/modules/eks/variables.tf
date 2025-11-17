variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "The first value should be the public subnet"
  type        = list(string)
}

variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "configure_kubectl" {
  type    = bool
  default = true
}

variable "cluster_name" {
  type = string
}

variable "clusterendpointpublic_access" {
  description = "Enable public access to EKS API endpoint"
  type        = bool
  default     = false
}

variable "clusterendpointprivate_access" {
  description = "Enable private access to EKS API endpoint"
  type        = bool
  default     = true
}

variable "clusterendpointpublicaccesscidrs" {
  description = "CIDR allowlist for public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}