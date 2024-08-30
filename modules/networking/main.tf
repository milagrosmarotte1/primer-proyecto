#--------------------------------------------------------------------------------
#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#--------------------------------------------------------------------------------
#SUBNETS
resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnet_cidr_blocks)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.subnet_cidr_blocks, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
}

#--------------------------------------------------------------------------------
#INTERNET GATEWAY
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

#--------------------------------------------------------------------------------
#ROUTE TABLE
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.route_table_cidr_blocks
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

#--------------------------------------------------------------------------------
#Asociar
resource "aws_route_table_association" "my_route_table_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.my_route_table.id
}

