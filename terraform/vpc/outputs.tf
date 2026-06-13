output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
output "availability_zones" {
  description = "Availability Zones"
  value       = data.aws_availability_zones.available.names
}
output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}
output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}