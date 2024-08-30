#--------------------------------------------------------------------------------
#EC2
resource "aws_instance" "my_ec2" {
  count                  = length(var.ami_id)
  ami                    = element(var.ami_id, count.index)
  instance_type          = element(var.instance_type, count.index)
  subnet_id              = element(var.subnet_id, count.index)
  vpc_security_group_ids = [aws_security_group.rdp_instance.id]

  user_data = file("web-server.sh")
  tags = {
    Name = "MyWebServer-${count.index}"
  }
}

#--------------------------------------------------------------------------------
#SECURITY GROUP 
resource "aws_security_group" "my_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
    }
  }
}

#--------------------------------------------------------------------------------
#ALB
resource "aws_lb" "my_alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = var.subnet_id
}

#--------------------------------------------------------------------------------
# ALB Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

#--------------------------------------------------------------------------------
# Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

#--------------------------------------------------------------------------------
# Target Group Attachment
resource "aws_lb_target_group_attachment" "example" {
  count               = length(aws_instance.my_ec2)
  target_group_arn    = aws_lb_target_group.my_target_group.arn
  target_id           = aws_instance.my_ec2[count.index].id
  port                = 80
}

