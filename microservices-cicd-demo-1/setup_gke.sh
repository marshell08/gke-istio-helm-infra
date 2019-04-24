#!/usr/bin/env bash

export PROJECT=microservices-lcbo-demo
export CLUSTER=gke-deploy-cluster
export ZONE=us-central1-b

gcloud config set project microservices-lcbo-demo

gcloud container clusters create ${CLUSTER} \
    --project=${PROJECT} \
    --zone=${ZONE} \
    --num-nodes=5
    --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"
