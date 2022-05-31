resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.7.1"
  namespace        = "cert-manager"
  create_namespace = true
  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "kubernetes_secret" "route53-access-secret" {
  metadata {
    name = "route53-access-secret"
    namespace = helm_release.cert-manager.namespace
  }
  data = {
    route53-access-key = var.cluster_issuer_route53_access_key
  }
  type = "Opaque"
}

resource "helm_release" "cert-manager-cluster-issuer" {
  name      = "cert-manager-cluster-issuer"
  chart     = "${path.module}/cert-manager-cluster-issuer"
  namespace = helm_release.cert-manager.namespace

  set {
    name  = "clusterIssuer.acme.email"
    value = var.cluster_issuer_email
  }

  set {
    name  = "clusterIssuer.acme.server"
    value = var.cluster_issuer_acme_server
  }

  set {
    name  = "clusterIssuer.selector.route53.region"
    value = var.cluster_issuer_route53_region
  }
  set {
    name  = "clusterIssuer.selector.dnsZones"
    value = "{${join(",", var.cluster_issuer_selector_dns_zones)}}"
  }

  set {
    name  = "clusterIssuer.selector.route53.hostedZoneID"
    value = var.cluster_issuer_route53_hosted_zone_id
  }
  set {
    name  = "clusterIssuer.selector.route53.accessKeyID"
    value = var.cluster_issuer_route53_access_key_id
  }
  set {
    name  = "clusterIssuer.selector.route53.secretAccessKeySecretRefName"
    value = kubernetes_secret.route53-access-secret.metadata[0].name
  }
  set {
    name  = "clusterIssuer.selector.route53.secretAccessKeySecretRefValue"
    value = "route53-access-key"
  }
}

resource "helm_release" "cert-manager-certificate" {
  name      = "cert-manager-certificate"
  chart     = "${path.module}/cert-manager-certificate"
  namespace = helm_release.cert-manager.namespace

  set {
    name  = "certificate.clusterIssuerRefName"
    value = helm_release.cert-manager-cluster-issuer.metadata[0].name
  }
  set {
    name  = "certificate.dnsNames"
    value = "{${join(",", var.certificate_dns_Names)}}"
  }
}