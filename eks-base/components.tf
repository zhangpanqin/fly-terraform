module "components" {
  source                                = "components"
  cluster_name                          = module.eks.cluster_id
  cluster_issuer_route53_hosted_zone_id = var.cluster_issuer_route53_hosted_zone_id
  cluster_issuer_email                  = var.cluster_issuer_email
  cluster_issuer_route53_access_key     = var.cluster_issuer_route53_access_key
  cluster_issuer_route53_access_key_id  = var.cluster_issuer_route53_access_key_id
}