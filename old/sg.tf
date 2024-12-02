resource "aws_security_group" "app_sg" {
  name        = "${var.ecs_service_name}-sg"
  description = "trading_signals_app_sg"
  vpc_id      = aws_vpc.crypto_trading_signal_vpc.id
}

resource "aws_security_group_rule" "app_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs_alb_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [aws_vpc.crypto_trading_signal_vpc.cidr_block]
  }

resource "aws_security_group_rule" "app_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.app_sg.id

  from_port   = 8298
  to_port     = 8298
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
