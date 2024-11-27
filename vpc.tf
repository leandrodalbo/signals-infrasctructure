resource "aws_vpc" "crypto_trading_signal_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}_vpc"
  }

}

resource "aws_subnet" "crypto_trading_signal_public_subnet_a" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.public_subnet_cidr_a
  availability_zone = var.public_subnet_zone_a

  tags = {
    Name = "${var.env}_public_subnet_a"
  }
}

resource "aws_subnet" "crypto_trading_signal_public_subnet_b" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.public_subnet_cidr_b
  availability_zone = var.public_subnet_zone_b

  tags = {
    Name = "${var.env}_public_subnet_b"
  }
}


resource "aws_subnet" "crypto_trading_signal_public_subnet_c" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.public_subnet_cidr_c
  availability_zone = var.public_subnet_zone_c

  tags = {
    Name = "${var.env}_public_subnet_c"
  }
}

resource "aws_subnet" "crypto_trading_signal_private_subnet_a" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = var.private_subnet_zone_a

  tags = {
    Name = "${var.env}_private_subnet_a"
  }
}

resource "aws_subnet" "crypto_trading_signal_private_subnet_b" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = var.public_subnet_zone_b

  tags = {
    Name = "${var.env}_private_subnet_b"
  }
}

resource "aws_subnet" "crypto_trading_signal_private_subnet_c" {
  vpc_id            = aws_vpc.crypto_trading_signal_vpc.id
  cidr_block        = var.private_subnet_cidr_c
  availability_zone = var.private_subnet_zone_c

  tags = {
    Name = "${var.env}_private_subnet_c"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.crypto_trading_signal_vpc.id

  tags = {
    Name = "${var.env}_public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.crypto_trading_signal_vpc.id

  tags = {
    Name = "${var.env}_private_route_table"
  }
}

resource "aws_route_table_association" "public_route_a_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_public_subnet_a.id
}

resource "aws_route_table_association" "public_route_b_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_public_subnet_b.id
}

resource "aws_route_table_association" "public_route_c_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_public_subnet_c.id
}

resource "aws_route_table_association" "private_route_a_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_private_subnet_a.id
}

resource "aws_route_table_association" "private_route_b_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_private_subnet_b.id
}

resource "aws_route_table_association" "private_route_c_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.crypto_trading_signal_private_subnet_c.id
}

resource "aws_eip" "private_ip_gw" {
  associate_with_private_ip = var.private_ip_gw

  tags = {
    Name = "${var.env}-private_eip_gw"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.private_ip_gw.id
  subnet_id     = aws_subnet.crypto_trading_signal_public_subnet_a.id

  tags = {
    Name = "${var.env}_nat_gw"
  }

  depends_on = [aws_eip.private_ip_gw]
}


resource "aws_route" "nat_gw_route" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.crypto_trading_signal_vpc.id


  tags = {
    Name = "${var.env}_internet_gw"
  }
}


resource "aws_route" "internet_gw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.internet_gw.id
  destination_cidr_block = "0.0.0.0/0"
}