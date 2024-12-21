terraform {
  backend "s3" {}
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# data "aws_s3_object" "sslcert" {
#   key    = var.ssl_cert
#   bucket = var.bucket
# }


data "aws_route53_zone" "signal_api_domain" {
  name         = var.api_domain
  private_zone = false
}

