provider "aws" {
    region = "${var.region}"
}

terraform {
  backend "s3" {
    
  }
}

resource "aws_vpc" "crypto_trading_signal_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name= "${env}-vpc"
    }
  
}

resource "aws_subnet" "crypto_trading_signal_public_subnet_a" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.public_subnet_cidr_a
    availability_zone = var.public_subnet_zone_a
    
    tags = {
        Name= "${env}-public-subnet-a"
    }
}

resource "aws_subnet" "crypto_trading_signal_public_subnet_b" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.public_subnet_cidr_b
    availability_zone = var.public_subnet_zone_b
    
    tags = {
        Name= "${env}-public-subnet-b"
    }
}


resource "aws_subnet" "crypto_trading_signal_public_subnet_c" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.public_subnet_cidr_c
    availability_zone = var.public_subnet_zone_c
    
    tags = {
        Name= "${env}-public-subnet-c"
    }
}


resource "aws_subnet" "crypto_trading_signal_private_subnet_a" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.private_subnet_cidr_a
    availability_zone = var.private_subnet_zone_a
    
    tags = {
        Name= "${env}-private-subnet-a"
    }
}

resource "aws_subnet" "crypto_trading_signal_private_subnet_b" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.private_subnet_cidr_b
    availability_zone = var.public_subnet_zone_b
    
    tags = {
        Name= "${env}-private-subnet-b"
    }
}


resource "aws_subnet" "crypto_trading_signal_private_subnet_c" {
    vpc_id = aws_vpc.crypto_trading_signal_vpc.id
    cidr_block = var.private_subnet_cidr_c
    availability_zone = var.private_subnet_zone_c
    
    tags = {
        Name= "${env}-private-subnet-c"
    }
}