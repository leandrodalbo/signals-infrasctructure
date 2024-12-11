output "vpc_id" {
  value     = aws_vpc.signalsvpc.id
  sensitive = true
}

output "vpc_cidr" {
  value     = aws_vpc.signalsvpc.cidr_block
  sensitive = true
}

output "public_subnet_a_id" {
  value     = aws_subnet.public_subnet_a.id
  sensitive = true
}

output "public_subnet_b_id" {
  value     = aws_subnet.public_subnet_b.id
  sensitive = true
}

output "public_subnet_c_id" {
  value     = aws_subnet.public_subnet_c.id
  sensitive = true
}

output "private_subnet_a_id" {
  value     = aws_subnet.private_subnet_a.id
  sensitive = true
}

output "private_subnet_b_id" {
  value     = aws_subnet.private_subnet_b.id
  sensitive = true
}

output "private_subnet_c_id" {
  value     = aws_subnet.private_subnet_c.id
  sensitive = true
}

output "dbhost" {
  value     = aws_db_instance.db.address
  sensitive = true
}

output "dbpswd" {
  value     = aws_secretsmanager_secret_version.dbpswd_version.secret_string
  sensitive = true
}

output "clusterid" {
  value     = aws_ecs_cluster.signals_cluster.id
  sensitive = true
}

output "clustername" {
  value     = aws_ecs_cluster.signals_cluster.name
  sensitive = true
}

output "alb_arn" {
  value     = aws_alb.signals-alb.arn
  sensitive = true
}

output "alb_dns" {
  value     = aws_alb.signals-alb.dns_name
  sensitive = true
}

output "alb_cert" {
  value     = aws_iam_server_certificate.alb_cert.arn
  sensitive = true
}


output "cluster_role_name" {
  value = aws_iam_role.cluster_role.name
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster_role.arn
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "alb_sg_id" {
  value     = aws_security_group.albsg.id
  sensitive = true
}

