#!/usr/bin/env bash

export PROJECT=microservices-lcbo-final-demo1
export CLUSTER=gke-deploy-cluster
export ZONE=us-central1-b

gcloud config set project microservices-lcbo-final-demo1

gcloud services enable container.googleapis.com 
gcloud services enable containerregistry.googleapis.com 
gcloud services enable cloudbuild.googleapis.com 
gcloud services enable sourcerepo.googleapis.com 

gcloud container clusters create ${CLUSTER} \
    --project=${PROJECT} \
    --zone=${ZONE} \
    --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"


export PROJECT_NUMBER="$(gcloud projects describe \
    $(gcloud config get-value core/project -q) --format='get(projectNumber)')"

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/container.developer
