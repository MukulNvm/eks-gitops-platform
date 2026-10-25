module "eks" {
  source      = "terraform-aws-modules/eks/aws"
  version     = "21.26.0"
  enable_irsa = false

  name               = var.cluster_name
  kubernetes_version = "1.36"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  endpoint_private_access      = true
  endpoint_public_access       = true
  endpoint_public_access_cidrs = [var.admin_cidr]

  enable_cluster_creator_admin_permissions = true
  create_kms_key                           = false
  encryption_config                        = null

  addons = {
    coredns                = {}
    eks-pod-identity-agent = { before_compute = true }
    kube-proxy             = {}
    vpc-cni                = { before_compute = true }
  }

  eks_managed_node_groups = {
    dev = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 20
      min_size       = 1
      max_size       = 1
      desired_size   = 1
    }
  }
}