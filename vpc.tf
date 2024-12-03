resource "aws_vpc" "signalsvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.env}-${var.appname}-vpc"
    Environment = var.env
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.public_cidr_a
  availability_zone = var.zone_a

  tags = {
    Name        = "${var.env}_public_subnet_a"
    Environment = var.env
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.public_cidr_b
  availability_zone = var.zone_b

  tags = {
    Name        = "${var.env}_public_subnet_b"
    Environment = var.env
  }
}


resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.public_cidr_c
  availability_zone = var.zone_c

  tags = {
    Name        = "${var.env}_public_subnet_c"
    Environment = var.env
  }
}


resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.zone_a

  tags = {
    Name        = "${var.env}_private_subnet_a"
    Environment = var.env
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.zone_b

  tags = {
    Name        = "${var.env}_private_subnet_b"
    Environment = var.env
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.signalsvpc.id
  cidr_block        = var.private_cidr_c
  availability_zone = var.zone_c

  tags = {
    Name        = "${var.env}_private_subnet_c"
    Environment = var.env
  }
}


resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.signalsvpc.id

  tags = {
    Name        = "${var.env}-${var.appname}-public-routing"
    Environment = var.env
  }

}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.signalsvpc.id

  tags = {
    Name        = "${var.env}-${var.appname}-private-routing"
    Environment = var.env
  }
}

resource "aws_eip" "natgwip" {
  associate_with_private_ip = var.nateip
  vpc                       = true
  tags = {
    Name        = "${var.env}-${var.appname}-natgw-ip"
    Environment = var.env
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgwip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name        = "${var.env}-${var.appname}-natgw"
    Environment = var.env
  }

  depends_on = [aws_eip.natgwip]
}

resource "aws_route" "natgwroute" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.natgw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.signalsvpc.id

  tags = {
    Name        = "${var.env}-${var.appname}-igw"
    Environment = var.env
  }
}

resource "aws_route" "signals-public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_route_table_association" "public_subnet_a_association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_a.id
}

resource "aws_route_table_association" "public_subnet_b_association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_b.id
}

resource "aws_route_table_association" "public_subnet_c_association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_c.id
}

resource "aws_route_table_association" "private_subnet_a_association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnet_a.id
}

resource "aws_route_table_association" "private_subnet_b_association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnet_b.id
}

resource "aws_route_table_association" "private_subnet_c_association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnet_c.id
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "dbsubnetgroup"
  subnet_ids = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]
}