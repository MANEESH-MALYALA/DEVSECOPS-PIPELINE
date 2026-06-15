# ===================================================================
# Outputs - useful information shown after Terraform runs
# ===================================================================

output "s3_bucket_name" {
  description = "Name of the S3 bucket created"
  value       = aws_s3_bucket.demo_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket (used by other AWS services)"
  value       = aws_s3_bucket.demo_bucket.arn
}

output "vpc_id" {
  description = "ID of the VPC created"
  value       = aws_vpc.demo_vpc.id
}

output "security_group_id" {
  description = "ID of the demo security group"
  value       = aws_security_group.demo_sg.id
}