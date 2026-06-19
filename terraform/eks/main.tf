locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment_name
    ManagedBy   = "Terraform"
    Owner       = "Susmit Das"
  }
}
module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "~> 21.0"
  name                                     = var.cluster_name
  kubernetes_version                       = "1.35"
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.private_subnet_ids
  endpoint_public_access                   = true
  endpoint_private_access                  = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    default = {
      name           = "bankapp-ng"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
  }
  tags = merge(local.common_tags,
    {
      Name = var.cluster_name
  })
}