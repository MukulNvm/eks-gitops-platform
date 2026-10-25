variable "aws_region" {
  description = "AWS region for the platform resources."
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Project name used for resource tags."
  type        = string
  default     = "eks-gitops-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "eks-gitops-platform-dev"
}
variable "admin_cidr" {
  description = "Your public IPv4 CIDR allowed to access the EKS API."
  type        = string
}