
# locals {
#   input_data = jsondecode(data.aws_s3_object.sslcert.body)
# }

# resource "aws_iam_server_certificate" "alb_cert" {
#   name             = "signals_alb_cert"
#   certificate_body = base64decode(local.input_data.cert)
#   private_key      = base64decode(local.input_data.key)
# }

resource "aws_acm_certificate" "signals_api_certificate" {
  domain_name       = "*.${var.api_domain}"
  validation_method = "DNS"
}

resource "aws_route53_record" "api_cert_validation_record" {
  name            = element(aws_acm_certificate.signals_api_certificate.domain_validation_options[*].resource_record_name, 0)
  type            = element(aws_acm_certificate.signals_api_certificate.domain_validation_options[*].resource_record_type, 0)
  zone_id         = data.aws_route53_zone.signal_api_domain.zone_id
  records         = [element(aws_acm_certificate.signals_api_certificate.domain_validation_options[*].resource_record_value, 0)]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "signals_api_cert_validation" {
  certificate_arn         = aws_acm_certificate.signals_api_certificate.arn
  validation_record_fqdns = [aws_route53_record.api_cert_validation_record.fqdn]
}

