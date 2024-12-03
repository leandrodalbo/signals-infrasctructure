resource "aws_security_group" "albsg" {
  name        = "${var.env}-${var.appname}-alb-sg"
  description = "trading_signals_alb_sg"
  vpc_id      = aws_vpc.signalsvpc.id
}

resource "aws_security_group_rule" "albin" {
  type              = "ingress"
  security_group_id = aws_security_group.albsg.id

  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "albout" {
  type              = "egress"
  security_group_id = aws_security_group.albsg.id

  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
