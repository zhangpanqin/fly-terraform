variable "cluster_name" {
  default = "panqin-eks"
}

variable "region" {
  default = "us-east-2"
}

variable "profile" {
  default = "saml"
}

variable "cluster_issuer_email" {
  description = "Email address used for ACME registration"
  type        = string
}
variable "cluster_issuer_route53_access_key" {
  description = "Route53 accessKey"
  type = string
}

variable "cluster_issuer_route53_hosted_zone_id" {
  description = "Route53 hostedZoneID"
  type        = string
}
variable "cluster_issuer_route53_access_key_id" {
  description = "Route53 accessKeyID"
  type        = string
}