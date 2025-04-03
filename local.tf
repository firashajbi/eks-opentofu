locals {
    env ="production"
    region ="eu-central-1"
    cidr_block="10.0.0.0/16"
    cluster_name="eks_main"
    eks_version = "1.30"
    available_zone1 ="eu-central-1a"
    available_zone2 ="eu-central-1b"
    instance_types ="t3.large"
}

locals {
  eks_node_policies = ["AmazonEC2ContainerRegistryReadOnly", "AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy"]
}

data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}