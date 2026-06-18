output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.myvpc.id
}
output "vpc_name" {
  description = "Name of the VPC"
  value       = aws_vpc.myvpc.tags["Name"]
}
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
output "public_subnet_ids" {
  description = "IDs of Public Subnets"
  value = [
    aws_subnet.public_sn_1.id,
    aws_subnet.public_sn_2.id
  ]
}
output "private_subnet_ids" {
  description = "IDs of Private Subnets"
  value = [
    aws_subnet.private_sn_1.id,
    aws_subnet.private_sn_2.id
  ]
}
output "nat_gateway_ids" {
  description = "IDs of NAT Gateways"
  value = [
    aws_nat_gateway.nat_1.id,
    aws_nat_gateway.nat_2.id,
  ]
}
output "nat_gateway_eips" {
  description = "NAT Elastic IPs"
  value = [
    aws_eip.nat_eip_1.public_ip,
    aws_eip.nat_eip_2.public_ip
  ]
}