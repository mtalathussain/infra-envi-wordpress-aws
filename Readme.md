1. Configure AWS 

2. Configure kubectl with the Amazon EKS Cluster:
   $ aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)



