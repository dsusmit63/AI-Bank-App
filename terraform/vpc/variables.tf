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
variable "cluster_name" {
  type        = string
  description = "Cluster Name"
}
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}
variable "public_subnet_1_cidr" {
  type        = string
  description = "Public Subnet 1 CIDR"
}
variable "public_subnet_2_cidr" {
  type        = string
  description = "Public Subnet 2 CIDR"
}
variable "private_subnet_1_cidr" {
  type        = string
  description = "Private Subnet 1 CIDR"
}
variable "private_subnet_2_cidr" {
  type        = string
  description = "Private Subnet 2 CIDR"
}