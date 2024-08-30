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

#--------------------------------------------------------------------------------
#SECURITY GROUPS
variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "inbound_rules" {
  description = "List of inbound rule maps"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "outbound_rules" {
  description = "List of outbound rule maps"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

#--------------------------------------------------------------------------------
#EC2
variable "instance_type" {
  description = "EC2 instance type"
  type        = list(string)
}

#--------------------------------------------------------------------------------
#ELB
variable "lb_name" {
  type = string
}

variable "lb_type" {
  type = string
}

#--------------------------------------------------------------------------------
# ALB Listener
variable "lb_listener_port" {
  type = number
}

variable "lb_listener_protocol" {
  type = string
}

#--------------------------------------------------------------------------------
# Target Group
variable "lb_target_group_name" {
  type = string
}

variable "lb_target_group_port" {
  type = number
}

variable "lb_target_group_protocol" {
  type = string
}
