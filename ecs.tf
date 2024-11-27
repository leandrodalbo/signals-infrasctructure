resource "aws_ecs_cluster" "crypto_trading_signals_cluster" {
  name = "${var.env}-${var.cluster_name}"
}

resource "aws_alb" "crypto_trading_signals_alb" {
  name            = "${var.env}-${var.alb_name}"
  internal        = false
  security_groups = [aws_security_group.ecs_alb_sg.id]
  subnets = [aws_subnet.crypto_trading_signal_public_subnet_a.id,
    aws_subnet.crypto_trading_signal_public_subnet_b.id,
  aws_subnet.crypto_trading_signal_public_subnet_c.id]

  tags = {
    Name = "${var.env}-alb"
  }
}

resource "aws_alb_target_group" "ecs_default_target_group" {
  name     = "${aws_ecs_cluster.crypto_trading_signals_cluster.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.crypto_trading_signal_vpc.id

  tags = {
    Name = "${var.env}_default_target_group"
  }
}

resource "aws_lb_listener" "crypto_trading_signals_alb_listener" {
  load_balancer_arn = aws_alb.crypto_trading_signals_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_default_target_group.arn
  }

  depends_on = [aws_alb_target_group.ecs_default_target_group]
}

resource "aws_iam_role" "ecs_cluster_role" {
  name               = "${aws_ecs_cluster.crypto_trading_signals_cluster.name}-rl"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "Service": [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com",
            "application-autoscaling.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ] 
}
EOF
}

resource "aws_iam_role_policy" "ecs_cluste_policy" {
  name   = "${aws_ecs_cluster.crypto_trading_signals_cluster.name}-pol"
  role   = aws_iam_role.ecs_cluster_role.id
  policy = <<EOF
    {
      "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ecs:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "ecr:*",
          "rds:*",
          "sqs:*",
          "sns:*",
          "ssm:*",
          "s3:*",
          "cloudwatch:*",
          "logs:*"
      ],
      "Resource":"*"
    }
  ] 
    }
  EOF
}