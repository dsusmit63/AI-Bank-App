variable "project_name" {
  description = "Project Name"
  type = string
}
variable "aws_region" {
  description = "AWS Region"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for public subnet 1"
  type        = string
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for public subnet 2"
  type        = string
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for private subnet 1"
  type        = string
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for private subnet 2"
  type        = string
}
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}