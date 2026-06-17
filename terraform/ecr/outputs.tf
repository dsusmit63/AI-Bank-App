output "repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.bankapp_ecr.name
}
output "repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.bankapp_ecr.repository_url
}
output "repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.bankapp_ecr.arn
}
output "registry_id" {
  description = "Registry ID where the repository was created"
  value       = aws_ecr_repository.bankapp_ecr.registry_id
}