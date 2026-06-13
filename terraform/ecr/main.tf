locals {
  common_tags = {
    Project   = "AI-Bank-App"
    ManagedBy = "Terraform"
  }
}
resource "aws_ecr_repository" "bankapp_repository" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = local.common_tags
}