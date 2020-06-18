# portfolio-infra

After creating a cluster, run these commands to complete setup:

1. configure kubectl: gcloud container clusters get-credentials tf-webapp-268705-gke --region australia-southeast1-a

2) Set up k8s Dashboard:
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

3) Start proxy server to access Dashboard:
   kubectl proxy

4) In new terminal, create ClusterRoleBinding resource, to create admin-user and provide permission to access cluster:
   kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-eks-cluster/master/kubernetes-dashboard-admin.rbac.yaml

5) Generate token for admin-user:
   kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')

6) Access Dashboard at below link, and paste generated token:
   http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

To force update of deployments with new image:
kubectl rollout restart deployment portfolio-frontend-deployment
