resource "aws_alb" "signals-alb" {
  name               = "${var.env}-${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.signals_public_subnet_a.id, aws_subnet.signals_public_subnet_b.id]
  security_groups    = [aws_security_group.signals_alb_sg.id]

  tags = {
    Name        = "${var.env}-${var.app_name}-alb"
    Environment = var.env
  }
}

resource "aws_lb_target_group" "signals-alb-target-grp" {
  name        = "${var.env}-${var.app_name}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.aws-signals-vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/actuator/health"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.env
  }
}


resource "aws_lb_listener" "signals-alb-listener" {
  load_balancer_arn = aws_alb.signals-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.signals-alb-target-grp.arn
  }
}