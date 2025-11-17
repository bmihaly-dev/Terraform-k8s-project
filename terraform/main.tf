module "vpc" {
  source = "./modules/vpc"

  projectname = var.projectname
  clustername = local.ekscluster_name
  region       = var.region
}

# module "db" {
#   source = "./modules/db"

#   vpcid = module.vpc.vpcid
#   subnetids = module.vpc.privatedbsubnetids
#   vpccidrblock = module.vpc.vpccidrblock

#   tagname = var.projectname

# }

# module "ecr" {
#   source = "./modules/ecr"

#   region = var.region
#   projectname = var.projectname
#   profile = var.profile
# }

module "eks" 
{
  source = "./modules/eks"

  vpcid                          = module.vpc.vpcid
  clusterendpointpublic_access  = true
  clusterendpointprivate_access = false

  clusterendpointpublicaccesscidrs = ["0.0.0.0/0"]



  subnet_ids = [
    module.vpc.publicsubnetids[0],
    module.vpc.publicsubnetids[1],
    module.vpc.privatesubnetid
  ]

  projectname      = var.projectname
  aws_region        = var.region
  clustername      = local.ekscluster_name
  configure_kubectl = true
}

locals {
  eksclustername = "${var.project_name}-eks-cluster"
}