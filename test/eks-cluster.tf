module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id


#########################################################

#### EKS Managed Node Group(s) Doesnt work-- cos of aws_eks version mismatch ####

#   eks_managed_node_group_defaults = {
#     disk_size      = 50
#     instance_types = ["t2.small","t2.micro"]
#   }

#   eks_managed_node_groups = {
#     nodeGroup1 = {
#       min_size     = 2
#       max_size     = 8
#       desired_size = 2

#       instance_types = ["t2.small"]
#       capacity_type  = "ON_DEMAND"
#       additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
#     }
#   }


############################################################
#

# for an older version of the EKS-Module - ~ v17.x #

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      #additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.sg1.id,aws_security_group.sg2-ftp.id]
      asg_desired_capacity          = 2
      asg_min_size                  = 2
      asg_max_size                  = 4
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.small"
      #additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.sg1.id,aws_security_group.sg2-ftp.id]
      asg_desired_capacity          = 1
      asg_min_size                  = 1
      asg_max_size                  = 4
    },
 
 
  ]
#
############################################################

}

  

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
