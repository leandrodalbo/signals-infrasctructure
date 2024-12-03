resource "aws_db_instance" "db" {
  identifier          = var.dbid
  instance_class      = var.dbclass
  allocated_storage   = 5
  engine              = var.dbengine
  engine_version      = var.dbengineversion
  skip_final_snapshot = true
  publicly_accessible = true

  vpc_security_group_ids = [aws_security_group.dbsg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name

  username = var.dbuser
  password = aws_secretsmanager_secret_version.dbpswd_version.secret_string
  db_name  = var.dbname
}

resource "random_password" "randompwrd" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "dbpswd" {
  name = "${var.env}-secretpass"
}

resource "aws_secretsmanager_secret_version" "dbpswd_version" {
  secret_id     = aws_secretsmanager_secret.dbpswd.id
  secret_string = random_password.randompwrd.result
}
