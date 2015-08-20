variable "region" {
  description = "The AWS region to connect to."
}
variable "domain" {
  description = "The domain for which to create a redirect record."
}
variable "target" {
  description = "The target of the redirect."
}
variable "r53_zone_id" {
  description = "The Route 53 Zone ID of the DNS zone in which to create the redirect record."
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.domain}"
  website {
    redirect_all_requests_to = "${var.target}"
  }
}

resource "aws_route53_record" "r" {
  zone_id = "${var.r53_zone_id}"
  name = "${var.domain}"
  type = "A"
  alias {
    zone_id = "${aws_s3_bucket.b.hosted_zone_id}"
    name = "${aws_s3_bucket.b.website_domain}"
    evaluate_target_health = false
  }
}
