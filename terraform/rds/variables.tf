variable "aws_region" {
  description = "AWS Region"
  type        = string
}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "environment_name" {
  description = "Environment Name"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "db_name" {
  description = "Database Name"
  type        = string
}
variable "db_username" {
  description = "Database Username"
  type        = string
}
variable "eks_node_security_group_id" {
  description = "EKS Node Security Group ID"
  type        = string
}
variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}
