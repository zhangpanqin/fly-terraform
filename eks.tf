module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.7.2"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = false

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }
  eks_managed_node_groups = {
    default_node_group = {
      security_group_rules = {
        allow_control_plane = {
          description                   = "Allow all traffic from control plane"
          protocol                      = "all"
          from_port                     = 0
          to_port                       = 0
          type                          = "ingress"
          source_cluster_security_group = true # bit of reflection lookup
        }
      }
    }
  }
}