## Description
This Terraform module sets up an AWS environment including a Virtual Private Cloud (VPC), EC2 instances, a Security Group, an Application Load Balancer (ALB), and related resources.

## Requirements

| Name      | Version |
|-----------|---------|
| Terraform | >= 1.0  |
| aws       | ~> 5.0  |

## Providers

| Name | Version |
|------|---------|
| aws  | ~> 5.0  |

## Resources

| Name                                                  | Type 
|-------------------------------------------------------|------
|aws_vpc.my_vpc                                         |aws_vpc|
|aws_subnet.public_subnet                               |aws_subnet
|aws_internet_gateway.my_igw                            |aws_internet_gateway
|aws_route_table.my_route_table                         |aws_route_table
|aws_route_table_association.my_route_table_association |aws_route_table_association
|aws_instance.my_ec2                                    |aws_instance
|aws_security_group.my_sg                               |aws_security_group
|aws_lb.my_alb                                          |aws_lb
|aws_lb_listener.http_listener                          |aws_lb_listener
|aws_lb_target_group.my_target_group                    |aws_lb_target_group
|aws_lb_target_group_attachment.example                 |aws_lb_target_group_attachment

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|vpc_cidr_block |	The CIDR block for the VPC.	| string
|subnet_cidr_blocks	|A list of CIDR blocks for the subnets within the VPC. |	list(string)
|azs |	A list of availability zones where the subnets will be created.	 |list(string)
|route_table_cidr_blocks |	CIDR block for the route table used in the VPC. |	string
|security_group_name |	Name of the security group to be created. |	string
|security_group_description |	Description of the security group. |	string
|inbound_rules |	A list of inbound rules for the security group. |	list(object({ description = string, from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) }))
|outbound_rules |	A list of outbound rules for the security group. |	list(object({ description = string, from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) }))
|ami_id |	A list of AMI IDs to use for launching EC2 instances. |	list(string)
|instance_type |	A list of instance types to use for the EC2 instances. |	list(string)
|subnet_id |	A list of subnet IDs where the EC2 instances will be launched. |	list(string)
|lb_name |	Name of the Application Load Balancer (ALB). |	string
|lb_type |	Type of the ALB, typically "application" or "network". |	string
|lb_listener_port |	Port on which the ALB listener will listen. |	number
|lb_listener_protocol     |	Protocol for the ALB listener, e.g., "HTTP" or "HTTPS". |	string
|lb_target_group_name     |	Name of the target group for the ALB. |	string
|lb_target_group_port     |	Port on which the target group will receive traffic. |	number
|lb_target_group_protocol |	Protocol for the target group, e.g., "HTTP" or "HTTPS". |	string

## Outputs

| Name | Description |
|------|-------------|
|vpc_id	| The ID of the VPC created by the module. |	string
|subnet_ids |	A list of subnet IDs created by the module. |	list(string)
|security_group_id |	The ID of the security group created by the module. |	string
|alb_arn |	The ARN (Amazon Resource Name) of the Application Load Balancer. |	string
|alb_dns_name |	The DNS name of the Application Load Balancer. |	string
|target_group_arn |	The ARN of the target group associated with the ALB. |	string

## Example

```tf
module "vpc" {
  source                  = ""
  vpc_cidr_block          = "10.0.0.0/16"
  subnet_cidr_blocks      = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                     = ["us-east-2a", "us-east-2b"]
  route_table_cidr_blocks = "0.0.0.0/0"
}

module "ec2" {
  source                     = ""
  security_group_name        = "my-security-group"
  security_group_description = "My security group"
  vpc_id                     = module.vpc.vpc_id
  inbound_rules              = var.inbound_rules
  outbound_rules             = var.outbound_rules
  ami_id                     = [""ami-0abcdef1234567890"", "ami-0abcdef1234567891"]
  instance_type              = ["t2.micro", "t2.micro"]
  subnet_id                  = ["subnet-0a1b2c3d4e5f67890", "subnet-0a1b2c3d4e5f67891"]
  lb_name                    = "my-alb"
  lb_type                    = "application"
  lb_listener_port           = 80
  lb_listener_protocol       = "HTTP"
  lb_target_group_name       = "my-target-group"
  lb_target_group_port       = 80
  lb_target_group_protocol   = "HTTP"
}

## Usage

1. Initialize Terraform:
terraform init

2. Plan the Deployment:
terraform plan

3. Apply the Configuration:
terraform apply

4. Destroy the Infrastructure (when no longer needed):
terraform destroy
