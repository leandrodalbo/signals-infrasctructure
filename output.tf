output "vpc_id" {
  value = aws_vpc.crypto_trading_signal_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.crypto_trading_signal_vpc.cidr_block
}

output "public_subnet_a_id" {
  value = aws_subnet.crypto_trading_signal_public_subnet_a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.crypto_trading_signal_public_subnet_b.id
}
output "public_subnet_c_id" {
  value = aws_subnet.crypto_trading_signal_public_subnet_c.id
}

output "private_subnet_a_id" {
  value = aws_subnet.crypto_trading_signal_private_subnet_a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.crypto_trading_signal_private_subnet_b.id
}
output "private_subnet_c_id" {
  value = aws_subnet.crypto_trading_signal_private_subnet_c.id
}


output "alb_listener" {
  value = aws_lb_listener.crypto_trading_signals_alb_listener.arn
}


output "cluste_name" {
  value = aws_ecs_cluster.crypto_trading_signals_cluster.name
}


output "cluster_iam_role_name" {
  value = aws_iam_role.ecs_cluster_role.name
}


output "cluster_iam_role_arn" {
  value = aws_iam_role.ecs_cluster_role.arn
}

output "alb_dns" {
  value = aws_alb.crypto_trading_signals_alb.dns_name
}

output "mq_endpoint" {
  value = split(":",split("//",aws_mq_broker.rabbitmq_broker.instances.0.endpoints.0)[1])[0]
}

output "postgress_host" {
  value = aws_db_instance.crypto_trading_signal_db.address
}

output "postgress_port" {
  value = aws_db_instance.crypto_trading_signal_db.port
}

output "postgress_dbname" {
  value = aws_db_instance.crypto_trading_signal_db.db_name
}


