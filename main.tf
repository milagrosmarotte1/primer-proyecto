module "vpc" {
  source                  = "./modules/networking"
  vpc_cidr_block          = var.vpc_cidr_block
  subnet_cidr_blocks      = var.subnet_cidr_blocks
  azs                     = var.azs
  route_table_cidr_blocks = var.route_table_cidr_blocks
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  ami_ids = [data.aws_ami.amazon-linux-2.id, data.aws_ami.amazon-linux-2.id]
}

module "ec2" {
  source                     = "./modules/EC2"
  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  vpc_id                     = module.vpc.vpc_id
  inbound_rules              = var.inbound_rules
  outbound_rules             = var.outbound_rules

  ami_id        = local.ami_ids
  instance_type = var.instance_type
  subnet_id     = module.vpc.subnet_ids
  

  lb_name = var.lb_name
  lb_type = var.lb_type

  lb_listener_port = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol

  lb_target_group_name = var.lb_target_group_name
  lb_target_group_port = var.lb_target_group_port
  lb_target_group_protocol = var.lb_target_group_protocol
}

