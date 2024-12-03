resource "aws_security_group" "dbsg" {
  name   = "${var.env}-db-sg"
  vpc_id = aws_vpc.signalsvpc.id
}

resource "aws_security_group_rule" "dbin" {
  type              = "ingress"
  security_group_id = aws_security_group.dbsg.id

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "dbout" {
  type              = "egress"
  security_group_id = aws_security_group.dbsg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}