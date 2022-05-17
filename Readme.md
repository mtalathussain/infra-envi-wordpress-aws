1. Configure AWS 

2. Configure kubectl with the Amazon EKS Cluster:
   $ aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)


3. Horizontal Pod AutoScaling:

kubectl autoscale deployment wordpress --cpu-percent=50 --min=1 --max=10

4. Run a load for HPA
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://wordpress; done"
