#--------------------------------------------------------------------------------
#VPC
vpc_cidr_block = "10.0.0.0/16"

#--------------------------------------------------------------------------------
#Subnets - 2 subnets
subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
azs                = ["us-east-2a", "us-east-2b"]

#--------------------------------------------------------------------------------
#Route table
route_table_cidr_blocks = "0.0.0.0/0"

#--------------------------------------------------------------------------------
#Security Groups
security_group_name        = "my-security-group"
security_group_description = "My security group"
inbound_rules = [
  {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

outbound_rules = [
  {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

#--------------------------------------------------------------------------------
#EC2 - 2 instancias
instance_type = ["t2.micro", "t2.micro"]

#--------------------------------------------------------------------------------
#ELB
lb_name = "my-alb"
lb_type = "application"

#--------------------------------------------------------------------------------
# ALB Listener
lb_listener_port = 80
lb_listener_protocol = "HTTP"

#--------------------------------------------------------------------------------
#Target group
lb_target_group_name = "my-target-group"
lb_target_group_port = 80
lb_target_group_protocol = "HTTP"