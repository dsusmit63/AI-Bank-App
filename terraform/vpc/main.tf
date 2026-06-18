locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment_name
    ManagedBy   = "Terraform"
    Owner       = "Susmit Das"
  }
}
# Availibility Zones
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "myvpc" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-vpc"
  })
}

# Public Subnet - 1
resource "aws_subnet" "public_sn_1" {

  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = true

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-public-subnet-1"

      "kubernetes.io/role/elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

# Public Subnet - 2
resource "aws_subnet" "public_sn_2" {

  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = true

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-public-subnet-2"

      "kubernetes.io/role/elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

# Private Subnet - 1
resource "aws_subnet" "private_sn_1" {

  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-private-subnet-1"

      "kubernetes.io/role/internal-elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

# Private Subnet - 2
resource "aws_subnet" "private_sn_2" {

  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-private-subnet-2"

      "kubernetes.io/role/internal-elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.myvpc.id

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-public-route-table"
    }
  )
}

# Public Route Table Association With Public Subnet 1
resource "aws_route_table_association" "public_1" {

  subnet_id      = aws_subnet.public_sn_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Public Route Table Association With Public Subnet 2
resource "aws_route_table_association" "public_2" {

  subnet_id      = aws_subnet.public_sn_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Elastic IP - 1 [NAT Gateway - 1]
resource "aws_eip" "nat_eip_1" {

  domain = "vpc"

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-nat-eip-1"
    }
  )
}

# Elastic IP - 2 [NAT Gateway - 2]
resource "aws_eip" "nat_eip_2" {

  domain = "vpc"

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-nat-eip-2"
  })
}

# NAT GATEWAY - 1 [Public Subnet 1]
resource "aws_nat_gateway" "nat_1" {

  allocation_id = aws_eip.nat_eip_1.id

  subnet_id = aws_subnet.public_sn_1.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-nat-1"
    }
  )
}

# NAT GATEWAY - 2 [Public Subnet 2]
resource "aws_nat_gateway" "nat_2" {

  allocation_id = aws_eip.nat_eip_2.id

  subnet_id = aws_subnet.public_sn_2.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-nat-2"
    }
  )
}

# Private Route Table - 1 
resource "aws_route_table" "private_rt_1" {

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-private-route-table-1"
    }
  )
}

# Private Route Table - 2 
resource "aws_route_table" "private_rt_2" {

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat_2.id
  }

  tags = merge(local.common_tags,
    {
      Name = "${var.project_name}-private-route-table-2"
    }
  )
}


resource "aws_route_table_association" "private_rt_1" {

  subnet_id      = aws_subnet.private_sn_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_rt_2" {

  subnet_id      = aws_subnet.private_sn_2.id
  route_table_id = aws_route_table.private_rt_2.id
}