variable "aws_region" {
  description = "AWS region used for the security lab."
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Name of the project used for resource naming."
  type        = string
  default     = "alpensec-security-lab"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "ssh_public_key_path" {
  description = "Local path to the SSH public key used for EC2 access."
  type        = string
  default     = "/Users/ogisha/.ssh/id_ed25519.pub"
}