locals {
  cluster_name = "goHLL-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
}