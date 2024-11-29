resource "aws_mq_broker" "rabbitmq_broker" {
  broker_name                = "rabbitmq-broker"
  engine_type                = "RabbitMQ"
  engine_version             = "3.11.20"
  host_instance_type         = "mq.t3.micro"
  publicly_accessible        = false
  auto_minor_version_upgrade = true
  apply_immediately          = true

  security_groups = [aws_security_group.rabbit_mq_sg.id]

  configuration {
    id       = aws_mq_configuration.rabbitmq_broker_config.id
    revision = aws_mq_configuration.rabbitmq_broker_config.latest_revision
  }

  user {
    username = var.rabbit_mq_username
    password = var.rabbit_mq_password
  }

  maintenance_window_start_time {
    day_of_week = "MONDAY"
    time_of_day = "18:00"
    time_zone   = "UTC"
  }
}


resource "aws_mq_configuration" "rabbitmq_broker_config" {
  description    = "RabbitMQ config"
  name           = "rabbitmq-broker"
  engine_type    = "RabbitMQ"
  engine_version = "3.11.20"
  data           = <<DATA
# Default RabbitMQ delivery acknowledgement timeout is 30 minutes in milliseconds
consumer_timeout = 1800000
DATA
}