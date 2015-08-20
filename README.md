# tf_aws_route53_redirect

Terraform module to create HTTP redirects using Route 53 and S3.

This module creates an S3 website bucket which redirects all requests to a specified target, and it creates
a Route 53 ALIAS record in a zone you control which points to that S3 bucket's website endpoint.

## Input variables:

* region - E.g. us-east-1
* domain - The domain you wish to redirect to the target.
* target - The target of the 301 redirect that S3 will send.
* zone_id - The Route 53 Zone ID of a DNS zone you control in which to create the "domain" record.

## Example:

If the zone `mydomain.com` is managed by by Route 53 and has Zone ID `Z1ABCDEFGHIJKL`, and you wish to redirect web requests to `old.mydomain.com` to `new.mydomain.com`, you could use the module thusly:

```
module "redirect" {
  source = "github.com/SmartThingsOSS/tf_aws_route53_redirect"
  region = "us-east-1"
  domain = "old.mydomain.com"
  target = "new.mydomain.com"
  zone_id = "Z1ABCDEFGHIJKL"
}
```