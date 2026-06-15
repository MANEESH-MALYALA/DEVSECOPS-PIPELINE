cat > /workspaces/devsecops-pipeline/terraform/variables.tf << 'EOF'
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used in resource naming"
  type        = string
  default     = "maneesh-devsecops"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "owner" {
  description = "Team or person responsible for these resources"
  type        = string
  default     = "platform-team"
}
TFEOF
