resource "aws_eks_cluster" "journal-cluster" {
  name = var.cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = var.cluster_role_arn
  version  = "1.31"

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs     = [var.public_access_cidr]
  }
}

resource "aws_eks_node_group" "journal-node" {
  cluster_name    = aws_eks_cluster.journal-cluster.name
  node_group_name = "journal-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t2.micro"]
  capacity_type = "SPOT"

  depends_on = [
    aws_eks_cluster.journal-cluster
  ]
}

resource "aws_eks_access_entry" "user" {
  cluster_name      = aws_eks_cluster.journal-cluster.name
  principal_arn     = var.eks_principle_arn
  type              = "STANDARD"

   depends_on = [
    aws_eks_node_group.journal-node
  ]
}

resource "aws_eks_access_policy_association" "policy_association" {
  cluster_name  = aws_eks_cluster.journal-cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.eks_principle_arn

  access_scope {
    type       = "cluster"
  }
     depends_on = [
    aws_eks_access_entry.user
  ]
}
