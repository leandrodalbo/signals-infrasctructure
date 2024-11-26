provider "aws" {
    region = "${var.region}"
}

terraform {
  backend "s3" {
    
  }
}


data "terraform_remote_state" "trading_signals_infra" {
    backend = "s3"

    config = {
      region = var.region
      bucket = var.state_bucket
      key = var.state_bucket_key
    }
}

resource "aws_ecs_cluster" "crypto_trading_signals_cluster" {
  name = "${var.env}_crypto_trading_signals_cluster"
}