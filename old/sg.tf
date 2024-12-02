data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ecs_alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "trading_signals_alb_sg"
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

resource "aws_security_group_rule" "alb_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs_alb_sg.id

  from_port   = 443
  to_port     = 443
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

resource "aws_security_group" "postgresdb_sg" {
  name   = "${var.env}-postgresdb-sg"
  vpc_id = aws_vpc.crypto_trading_signal_vpc.id
}

resource "aws_security_group_rule" "postgresdb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.postgresdb_sg.id

  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = [aws_vpc.crypto_trading_signal_vpc.cidr_block]
}

resource "aws_security_group_rule" "postgresdb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.postgresdb_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}