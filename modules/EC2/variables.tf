#--------------------------------------------------------------------------------
#EC2
variable "ami_id" {
  description = "ID of the AMI that will be used to launch the instance"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = list(string)
}

variable "subnet_id" {
  description = "ID of the subnet in which the instance will be launched"
  type        = list(string)
}

#--------------------------------------------------------------------------------
#SECURITY GROUP
variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to which the security group will be attached"
  type        = string
}

variable "inbound_rules" {
  description = "List of inbound rule maps"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
}

variable "outbound_rules" {
  description = "List of outbound rule maps"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
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

