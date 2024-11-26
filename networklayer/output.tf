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