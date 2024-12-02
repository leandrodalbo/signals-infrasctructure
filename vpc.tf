resource "aws_vpc" "aws-signals-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.env}-${var.app_name}-vpc"
    Environment = var.env
  }
}

resource "aws_internet_gateway" "aws-signals-igw" {
  vpc_id = aws_vpc.aws-signals-vpc.id
  tags = {
    Name        = "${var.env}-${var.app_name}-igw"
    Environment = var.env
  }
}

resource "aws_subnet" "signals_public_subnet_a" {
  vpc_id            = aws_vpc.aws-signals-vpc.id
  cidr_block        = var.public_subnet_cidr_a
  availability_zone = var.subnet_zone_a

  tags = {
    Name        = "${var.env}_public_subnet_a"
    Environment = var.env
  }
}

resource "aws_subnet" "signals_public_subnet_b" {
  vpc_id            = aws_vpc.aws-signals-vpc.id
  cidr_block        = var.public_subnet_cidr_b
  availability_zone = var.subnet_zone_b

  tags = {
    Name        = "${var.env}_public_subnet_b"
    Environment = var.env
  }
}

resource "aws_subnet" "signals_private_subnet_a" {
  vpc_id            = aws_vpc.aws-signals-vpc.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = var.subnet_zone_a

  tags = {
    Name        = "${var.env}_private_subnet_a"
    Environment = var.env
  }
}

resource "aws_subnet" "signals_private_subnet_b" {
  vpc_id            = aws_vpc.aws-signals-vpc.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = var.subnet_zone_b

  tags = {
    Name        = "${var.env}_private_subnet_b"
    Environment = var.env
  }
}


resource "aws_route_table" "signals-public-route-table" {
  vpc_id = aws_vpc.aws-signals-vpc.id

  tags = {
    Name        = "${var.env}-${var.app_name}-routing-table-public"
    Environment = var.env
  }
}

resource "aws_route" "signals-public-route" {
  route_table_id         = aws_route_table.signals-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws-signals-igw.id
}


resource "aws_route_table_association" "public_route_a_association" {
  route_table_id = aws_route_table.signals-public-route-table.id
  subnet_id      = aws_subnet.signals_public_subnet_a.id
}

resource "aws_route_table_association" "public_route_b_association" {
  route_table_id = aws_route_table.signals-public-route-table.id
  subnet_id      = aws_subnet.signals_public_subnet_b.id
}


resource "aws_db_subnet_group" "signals_db_subnet_group" {
  name = "${var.env}-db-subnet-group"
  subnet_ids = [aws_subnet.signals_private_subnet_a.id, aws_subnet.signals_private_subnet_b.id]

  tags = {
    Name = "${var.env}-signals-db-subnet-grp"
  }
}