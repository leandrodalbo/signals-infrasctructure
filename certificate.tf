data "aws_s3_object" "sslcert" {
  key    = var.ssl_cert
  bucket = var.bucket
}

locals {
  input_data = jsondecode(data.aws_s3_object.sslcert.body)
}

resource "aws_iam_server_certificate" "alb_cert" {
  name             = "signals_alb_cert"
  certificate_body = base64decode(local.input_data.cert)
  private_key      = base64decode(local.input_data.key)
}
