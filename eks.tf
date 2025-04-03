resource "aws_iam_role" "eks_cluster_role" {
  name ="${local.env}-${local.cluster_name}-eks-cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.eks_cluster_role.name     
}

resource "aws_eks_cluster" "eks" {
    name = "${local.env}-${local.cluster_name}"
    version = local.eks_version
    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
      endpoint_private_access = false
      endpoint_public_access = true

      subnet_ids = [
        aws_subnet.private_subnet_zone1.id,
        aws_subnet.private_subnet_zone2.id
      ]
    }
    
    access_config {
      authentication_mode = "API" #Config map still works but deprecated
      bootstrap_cluster_creator_admin_permissions = true  #using helm through opentofu
    }
    depends_on = [aws_iam_role_policy_attachment.eks]
  
}

