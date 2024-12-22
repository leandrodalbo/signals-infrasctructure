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


resource "aws_route53_record" "alb_record" {
  name    = "*.${var.api_domain}"
  type    = "A"
  zone_id = data.aws_route53_zone.signal_api_domain.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_alb.signals-alb.dns_name
    zone_id                = aws_alb.signals-alb.zone_id
  }
}

