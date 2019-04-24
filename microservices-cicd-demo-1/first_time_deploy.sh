#!/usr/bin/env bash

gcloud container clusters get-credentials gke-deploy-cluster --project=microservices-lcbo-demo --zone=us-central1-b
git clone git@github.com:marshell08/gcp-go-microservice-app1.git -b master
cd gcp-go-microservice-app1

kubectl create ns production

kubectl apply -f kubernetes/deployments/prod -n production
kubectl apply -f kubernetes/deployments/canary -n production
kubectl apply -f kubernetes/services -n production


kubectl get pods -n production -l app=gceme -l role=frontend
kubectl get pods -n production -l app=gceme -l role=backend

kubectl get service gceme-frontend -n production
export FRONTEND_SERVICE_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}"  --namespace=production services gceme-frontend)

curl http://$FRONTEND_SERVICE_IP/version
