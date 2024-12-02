resource "aws_security_group" "postgresdb_sg" {
  name   = "${var.env}-postgresdb-sg"
  vpc_id = aws_vpc.aws-signals-vpc.id
}

resource "aws_security_group_rule" "postgresdb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.postgresdb_sg.id

  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = [aws_vpc.aws-signals-vpc.cidr_block]
}

resource "aws_security_group_rule" "postgresdb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.postgresdb_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}