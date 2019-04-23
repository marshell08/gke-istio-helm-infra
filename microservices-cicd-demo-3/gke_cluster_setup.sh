#!/usr/bin/env bash

echo "Getting things ready....."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_REGION=us-central1
export INSTANCE_ZONE=us-central1-a
export PROJECT_NAME=microservices-cicd-demo-3
export CLUSTER_NAME=istio-cluster-demo-3
export CONTAINER_NAME=istio-container

echo "setup"
gcloud config set project ${PROJECT_NAME}
gcloud config set compute/zone ${INSTANCE_ZONE}

echo "enable services"
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com

echo "creating container engine cluster"
gcloud container clusters create ${CLUSTER_NAME} \
    --zone ${INSTANCE_ZONE} \
    --enable-autorepair \
    --enable-autoupgrade \
    --enable-autoscaling --min-nodes 3 --max-nodes 10 \
    --num-nodes 4 \
    --machine-type n1-standard-8 

echo "confirm cluster is running"
gcloud container clusters list

echo "get credentials"
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${INSTANCE_ZONE}

echo "confirm connection to cluster"
kubectl cluster-info

echo "create cluster administrator"
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin --user=$(gcloud config get-value account)

echo "list production namespaces"
kubectl get ns

echo "confirm the pod is running"
kubectl get pods

echo "list production services"
kubectl get svc

echo "------------------------------------"
echo "GKE cluster is now setup"
