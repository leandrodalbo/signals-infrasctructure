resource "aws_db_instance" "crypto_trading_signal_db" {
  identifier             = var.postgres_db_id
  instance_class         = var.db_instance_class
  allocated_storage      = 5
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  skip_final_snapshot    = true
  publicly_accessible    = true

  vpc_security_group_ids = [aws_security_group.postgresdb_sg.id]
  db_subnet_group_name = aws_db_subnet_group.signals_db_subnet_group.name

  username               = var.postgres_user_name
  password               = var.postgres_user_password
  db_name                = var.postgres_db_name

}
