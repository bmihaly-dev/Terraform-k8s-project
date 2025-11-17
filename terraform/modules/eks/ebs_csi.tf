data "awsiampolicydocument" "ebscsi_driver" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "awsiamrole" "ebscsidriver" {
  name               = "${awsekscluster.this.name}-ebs-csi-driver"
  assumerolepolicy = data.awsiampolicydocument.ebscsi_driver.json
}

resource "awsiamrolepolicyattachment" "ebscsidriver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = awsiamrole.ebscsidriver.name
}

resource "awsiampolicy" "ebscsidriver_encryption" {
  name = "${awsekscluster.this.name}-ebs-csi-driver-encryption"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:CreateGrant"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "awsiamrolepolicyattachment" "ebscsidriver_encryption" {
  policyarn = awsiampolicy.ebscsidriverencryption.arn
  role       = awsiamrole.ebscsidriver.name
}

resource "awsekspodidentityassociation" "ebscsidriver" {
  clustername    = awseks_cluster.this.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  rolearn        = awsiamrole.ebscsi_driver.arn
}

resource "awseksaddon" "ebs_csi" {
  clustername             = awseks_cluster.this.name
  addon_name               = "aws-ebs-csi-driver"
  serviceaccountrolearn = awsiamrole.ebscsi_driver.arn

  dependson = [awseksnodegroup.eksfunnodes, awseksaddon.podidentityagent]
}
