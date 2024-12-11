resource "aws_iam_server_certificate" "alb_cert" {
  name             = "signals_alb_cert"
  certificate_body = file("./conf/signals.crt")
  private_key      = file("./conf/signals.key")
}