output "terraform_state_bucket_name" {
  description = "S3 bucket used for Terraform remote state."
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_lock_table_name" {
  description = "DynamoDB table used for Terraform state locking."
  value       = aws_dynamodb_table.terraform_locks.name
}

output "aws_account_id" {
  description = "AWS account ID used for this deployment."
  value       = local.account_id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "security_server_public_ip" {
  description = "Public IP address of the security server."
  value       = aws_instance.security.public_ip
}

output "freeipa_private_ip" {
  description = "Private IP address of the FreeIPA server."
  value       = aws_instance.freeipa.private_ip
}

output "security_server_private_ip" {
  description = "Private IP address of the security server."
  value       = aws_instance.security.private_ip
}

output "workload_private_ip" {
  description = "Private IP address of the workload server."
  value       = aws_instance.workload.private_ip
}