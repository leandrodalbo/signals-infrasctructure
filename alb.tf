resource "aws_alb" "signals-alb" {
  name               = "${var.env}-${var.appname}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.albsg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]

  tags = {
    Name        = "${var.env}-${var.appname}-alb"
    Environment = var.env
  }
}