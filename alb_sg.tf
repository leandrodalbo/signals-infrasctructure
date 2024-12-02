resource "aws_security_group" "signals_alb_sg" {
  name        = "${var.env}-${var.app_name}-alb-sg"
  description = "trading_signals_alb_sg"
  vpc_id      = aws_vpc.aws-signals-vpc.id
}

resource "aws_security_group_rule" "signals_alb_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.signals_alb_sg.id

  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

}

resource "aws_security_group_rule" "signals_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.signals_alb_sg.id

  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
