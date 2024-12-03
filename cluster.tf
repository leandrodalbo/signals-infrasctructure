resource "aws_ecs_cluster" "signals_cluster" {
  name = "${var.env}-${var.appname}-cluster"

  tags = {
    Name        = "${var.env}-${var.appname}-cluster"
    Environment = var.env
  }
}

