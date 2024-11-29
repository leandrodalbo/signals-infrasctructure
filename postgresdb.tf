resource "aws_db_instance" "crypto_trading_signal_db" {
  identifier             = var.postgres_db_id
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "16.4"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.postgresdb_sg.id]
  username               = var.postgres_user_name
  password               = var.postgres_user_password
  db_name                = var.postgres_db_name
}