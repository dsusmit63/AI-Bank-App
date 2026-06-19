variable "aws_region" {
  type        = string
  description = "AWS Region"
}
variable "project_name" {
  type        = string
  description = "Project Name"
}
variable "environment_name" {
  type        = string
  description = "Environment Name"
}
variable "repository_name" {
  type        = string
  description = "ECR Repository Name"
}
variable "image_tag_mutability" {
  type        = string
  description = "Image Tag Mutability"
  validation {
    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.image_tag_mutability
    )
    error_message = "Value must be MUTABLE or IMMUTABLE."
  }
}