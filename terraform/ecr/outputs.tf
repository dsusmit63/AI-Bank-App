output "repository_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.bankapp_repository.name
}
output "repository_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.bankapp-repository.repository_url
}