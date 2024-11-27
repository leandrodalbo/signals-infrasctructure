resource "aws_security_group" "ecs_alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "alb_sg_cryptp_trading_signals"
  vpc_id      = aws_vpc.crypto_trading_signal_vpc.id

}

resource "aws_security_group_rule" "alb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs_alb_sg.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.ecs_alb_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
