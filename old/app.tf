data "template_file" "apptasktemplate" {
  template = file("task.json")

  vars = {
    image_url             = var.ecs_image_url
    container_port        = var.docker_container_port
    ecs_service_name      = var.ecs_service_name
    region                = var.region
    db_user               = var.postgres_user_name
    db_password           = var.postgres_user_password
    db_name               = var.postgres_db_name
    db_host               = aws_db_instance.crypto_trading_signal_db.address
    rabbit_host           = split(":",split("//",aws_mq_broker.rabbitmq_broker.instances.0.endpoints.0)[1])[0]
    rabbit_user           = var.rabbit_mq_username
    rabbit_password       = var.rabbit_mq_password
  }

  depends_on = [ aws_db_instance.crypto_trading_signal_db, aws_mq_broker.rabbitmq_broker ]
}


resource "aws_ecs_task_definition" "app_task_definition" {
  container_definitions    = data.template_file.apptasktemplate.rendered
  family                   = var.ecs_service_name
  cpu                      = 512
  memory                   = var.ecs_service_memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.fargate_role.arn
  task_role_arn            = aws_iam_role.fargate_role.arn

}

resource "aws_ecs_service" "app_ecs_service" {
  name            = var.ecs_service_name
  task_definition = aws_ecs_task_definition.app_task_definition.arn
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
            "ecs-tasks.amazonaws.com"
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
          "mq:*",
          "cloudwatch:*",
          "logs:*"
        ],
        "Resource":"*"
      }
    ] 
  }
  EOF
}