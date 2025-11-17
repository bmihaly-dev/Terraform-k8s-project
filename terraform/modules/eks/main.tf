resource "awseksaddon" "podidentityagent" {
  clustername = awseks_cluster.this.name
  addon_name   = "eks-pod-identity-agent"
}


// Master node
resource "awsekscluster" "this" {
  name     = var.cluster_name
  rolearn = awsiamrole.ekscluster.arn
  version  = "1.33"

  bootstrapselfmanaged_addons = true

  vpc_config {
    subnetids              = var.subnetids
    securitygroupids      = [awssecuritygroup.eks_cluster.id]
    endpointpublicaccess  = var.clusterendpointpublic_access
    endpointprivateaccess = var.clusterendpointprivate_access
    publicaccesscidrs     = var.clusterendpointpublicaccesscidrs
  }

  access_config {
    authentication_mode                         = "API"
    bootstrapclustercreatoradminpermissions = true
  }

  enabledclusterlog_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    awsiamrolepolicyattachment.eksclusterpolicy,
  ]
}

// Worker node
resource "awseksnodegroup" "eksfun_nodes" {
  clustername    = awseks_cluster.this.name
  nodegroupname = "eksfunnodes"
  noderolearn   = awsiamrole.eks_node.arn
  subnetids      = [var.subnetids[2]]
  instance_types  = ["t3.xlarge"]
  capacitytype   = "ONDEMAND"

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [
      scalingconfig[0].desiredsize,
      scalingconfig[0].maxsize,
      scalingconfig[0].minsize
    ]
  }


  labels = {
    "node-type" = "eksfunnodes"
  }

  tags = {
    Name = "eksfunnodes"
  }

  depends_on = [
    awsiamrolepolicyattachment.eksworkerpolicy,
    awsiamrolepolicyattachment.ecrreadpolicy,
    awsiamrolepolicyattachment.ekscnipolicy
  ]
}

// Automate local kubectl configuration
resource "terraformdata" "configurekubectl" {
  count      = var.configure_kubectl ? 1 : 0
  dependson = [awseks_cluster.this]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ap-south-1 --name ${trimspace(awsekscluster.this.name)}"
  }
}
