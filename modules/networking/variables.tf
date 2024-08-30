#--------------------------------------------------------------------------------
#VPC
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

#--------------------------------------------------------------------------------
#SUBNET
variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones for the public subnets"
  type        = list(string)
}

#--------------------------------------------------------------------------------
#ROUTE TABLE
variable "route_table_cidr_blocks" {
  description = "The CIDR block for the route table"
  type        = string
}
