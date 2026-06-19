output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.mysql.id
}

output "rds_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.mysql.arn
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_address" {
  description = "RDS Address"
  value       = aws_db_instance.mysql.address
}

output "rds_port" {
  description = "RDS Port"
  value       = aws_db_instance.mysql.port
}

output "rds_database_name" {
  description = "Database Name"
  value       = aws_db_instance.mysql.db_name
}

output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}

output "db_subnet_group_name" {
  description = "DB Subnet Group Name"
  value       = aws_db_subnet_group.this.name
}

output "secret_arn" {
  description = "Secrets Manager Secret ARN"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "secret_name" {
  description = "Secrets Manager Secret Name"
  value       = aws_secretsmanager_secret.db_secret.name
}