locals {
  cluster_name = "var.ekclustername-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}


#EKS cluster Module

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "local.cluster_name"
  cluster_version = "var.clusterversion"
  #role_arn        = ""
  #access_config {
    #authentication_mode = var.authentication_mode

    # See access entries below - this is a one time operation from the EKS API.
    # Instead, we are hardcoding this to false and if users wish to achieve this
    # same functionality, we will do that through an access entry which can be
    # enabled or disabled at any time of their choosing using the variable
    # var.enable_cluster_creator_admin_permissions
    #bootstrap_cluster_creator_admin_permissions = false
  #}

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "module.vpc.vpc_id"
  #subnet_ids               = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  #control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  depends_on = [
    module.vpc.var.vpcname,
    aws_security_group.all_worker_mgmt
  ]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["var.instancetype"]
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["var.instancetype"]
      #capacity_type  = "SPOT"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::828922131866:role/Clusteraccess"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}


