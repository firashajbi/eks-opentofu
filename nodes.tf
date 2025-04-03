 resource "aws_iam_role" "eks_node_role" {
  name ="${local.env}-${local.cluster_name}-eks-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_node_role" {
  for_each = toset(local.eks_node_policies)

  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_eks_node_group" "general" {
    cluster_name = aws_eks_cluster.eks.name
    version = local.eks_version
    node_group_name = "general"
    node_role_arn = aws_iam_role.eks_node_role.arn
    
    subnet_ids = [
        aws_subnet.private_subnet_zone1.id,
        aws_subnet.private_subnet_zone2.id
    ]
    
    capacity_type = "ON_DEMAND"
    instance_types = ["${local.instance_types}"]
    
    scaling_config {
        desired_size = 1
        max_size = 10
        min_size = 0
      
    }

    update_config {
      max_unavailable = 1
    }

    depends_on = [aws_iam_role_policy_attachment.eks_node_role]

    labels = {
      role ="general"
    }

    lifecycle {
      ignore_changes = [ scaling_config[0].desired_size ]
    }

}

