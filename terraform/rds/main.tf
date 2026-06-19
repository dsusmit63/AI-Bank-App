locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment_name
    ManagedBy   = "Terraform"
    Owner       = "Susmit Das"
  }
}
resource "random_password" "db_password" {
  length  = 16
  special = true
}
resource "aws_secretsmanager_secret" "db_secret" {
  name = "bankapp-rds-secret"
}
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}
resource "aws_security_group" "rds_sg" {
  name        = "bankapp-rds-sg"
  description = "Allow MySQL for EKS"
  vpc_id      = var.vpc_id
}
resource "aws_vpc_security_group_ingress_rule" "mysql_from_eks" {
  description                  = "Allow MySQL traffic from EKS Nodes"
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = var.eks_node_security_group_id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}
resource "aws_db_subnet_group" "this" {
  name       = "bankapp-db-subnet-group"
  subnet_ids = var.private_subnet_ids
}
resource "aws_db_instance" "mysql" {
  identifier              = "bankapp-mysql"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp3"
  storage_encrypted       = true
  db_name                 = var.db_name
  username                = var.db_username
  password                = random_password.db_password.result
  port                    = 3306
  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true
  backup_retention_period = 7
  deletion_protection     = false
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]
  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-rds"
  })
}