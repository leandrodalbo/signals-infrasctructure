data "template_file" "ecs_task_template" {
  template = file("tasktemplate.json")

  vars = {
    task_definition_name  = var.ecs_service_name
    image_url             = var.ecs_image_url
    spring_profile_active = var.spring_profile_active
    docker_container_port = var.docker_container_port
    ecs_service_name      = var.ecs_service_name
    region                = var.region
  }
}

resource "aws_iam_role" "fargate_role" {
  name               = "${var.ecs_service_name}-rl"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "Service": [
            "ecs.amazonaws.com",
            "ec2-tasks.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ] 
}
EOF
}

resource "aws_iam_role_policy" "fargate_role_policy" {
  name   = "${var.ecs_service_name}-pol"
  role   = aws_iam_role.fargate_role.id
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

resource "aws_ecs_task_definition" "app_task_definition" {
  container_definitions    = data.template_file.ecs_task_template.rendered
  family                   = var.ecs_service_name
  cpu                      = 512
  memory                   = var.ecs_service_memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.fargate_role.arn
  task_role_arn            = aws_iam_role.fargate_role.arn
}

resource "aws_alb_target_group" "ecs_fargate_target" {
  name        = "${var.ecs_service_name}-tg"
  port        = var.docker_container_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.crypto_trading_signal_vpc.id
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 30
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  tags = {
    Name = "${var.env}_${var.ecs_service_name}_tg"
  }

}

resource "aws_ecs_service" "app_ecs_service" {
  name            = var.ecs_service_name
  task_definition = var.ecs_service_name
  desired_count   = var.task_number
  cluster         = aws_ecs_cluster.crypto_trading_signals_cluster.name
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.crypto_trading_signal_public_subnet_a.id,
      aws_subnet.crypto_trading_signal_public_subnet_b.id,
    aws_subnet.crypto_trading_signal_public_subnet_c.id]
    security_groups  = [aws_security_group.app_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    container_name   = var.ecs_service_name
    container_port   = var.docker_container_port
    target_group_arn = aws_alb_target_group.ecs_fargate_target.arn
  }
}



resource "aws_lb_listener_rule" "app_alb_listener_rule" {
  listener_arn = aws_lb_listener.crypto_trading_signals_alb_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_fargate_target.arn
  }
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "${var.ecs_service_name}-logs"
}