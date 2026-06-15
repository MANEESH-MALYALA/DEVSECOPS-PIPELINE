# ===================================================================
# DevSecOps Pipeline - Demo Infrastructure
# WARNING: This file intentionally contains security misconfigurations
# Our pipeline (tfsec + Checkov + OPA) will catch all of them.
# ===================================================================

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# -------------------------------------------------------------------
# S3 Bucket (INTENTIONALLY INSECURE - for pipeline to catch)
# -------------------------------------------------------------------
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "${var.project_name}-demo-bucket-${var.environment}"

  # Missing tags (OPA will catch this)
}

# No encryption configured (tfsec will catch this)
# No versioning (Checkov will catch this)
# No public access block (tfsec will catch this)
# No logging (Checkov will catch this)

# -------------------------------------------------------------------
# VPC (basic networking)
# -------------------------------------------------------------------
resource "aws_vpc" "demo_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  # Missing flow logs (tfsec will catch this)
  # Missing tags (OPA will catch this)
}

# -------------------------------------------------------------------
# Security Group (INTENTIONALLY OVER-PERMISSIVE)
# -------------------------------------------------------------------
resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Demo security group"
  vpc_id      = aws_vpc.demo_vpc.id

  # Open to the world on port 22 (tfsec will scream)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}