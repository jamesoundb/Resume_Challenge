# google_site_verification.tf — DNS TXT record proving ownership of the domain
# to Google (Cloud Identity Free signup, which creates the GCP organisation).
# The value is public by nature (it lives in DNS), so it is safe to commit.

variable "google_site_verification" {
  description = "Token from Google's domain verification page, without the google-site-verification= prefix. Null = no record."
  type        = string
  default     = "2ZXV8ePd-q8PWtUf0mQvg296nttFdSmkmzkGcnVurck"
}

resource "aws_route53_record" "google_site_verification" {
  count = var.google_site_verification == null ? 0 : 1

  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "TXT"
  ttl     = 300
  records = ["google-site-verification=${var.google_site_verification}"]
}
