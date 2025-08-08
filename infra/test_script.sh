#!/bin/bash
terraform apply -auto-approve

RDS_ENDPOINT=$(terraform output -raw db_endpoint)
EKS_CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
EKS_REGION=$(terraform output -raw vpc_region)

aws eks --region $EKS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

sed -i "s/DB_ENDPOINT/$RDS_ENDPOINT/g" ../k8s/configmap.yaml

kubectl apply -f ../k8s/secret.yaml
kubectl apply -f ../k8s/configmap.yaml
kubectl apply -f ../k8s/deployment.yaml
kubectl apply -f ../k8s/service.yaml
