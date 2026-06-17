locals {
  common_tags = {
    Project     = "AI-Bank-App"
    Environment = var.environment_name
    ManagedBy   = "Terraform"
    Owner       = "Susmit Das"
  }
}
resource "aws_ecr_repository" "bankapp_ecr" {
  name                 = var.repository_name
  force_delete         = true
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = merge(local.common_tags,
    {
      Name = var.repository_name
  })
}