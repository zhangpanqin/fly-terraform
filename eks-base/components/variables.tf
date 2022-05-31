variable "cluster_name" {
  type = string
}

variable "cluster_issuer_acme_server" {
  description = "The ACME server URL"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "cluster_issuer_email" {
  description = "Email address used for ACME registration"
  type        = string
}

variable "cluster_issuer_route53_region" {
  description = "Route53 region"
  type        = string
  default     = "us-east-1"
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
variable "certificate_dns_Names" {
  type = list(string)
  default = ["mflyyou.com"]
}
variable "cluster_issuer_selector_dns_zones" {
  type = list(string)
  default = ["mflyyou.com"]
}

