variable "aws_region" {
  description = "AWS Region"
  type        = string
}
variable "project_name" {
  description = "Project Name"
  type = string
}
variable "environment_name" {
  description = "Environment Name"
  type = string
}
variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "private_subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}