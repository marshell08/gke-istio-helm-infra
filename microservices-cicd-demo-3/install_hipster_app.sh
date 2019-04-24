#!/usr/bin/env bash

git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
cd microservices-demo

gcloud container clusters get-credentials istio-cluster-demo-2 --zone=us-central1-a --project=microservices-lcbo-final-demo2

kubectl label namespace default istio-injection=enabled
kubectl apply -f ./istio-manifests

#skaffold run --default-repo=gcr.io/[PROJECT_ID]
skaffold run -p gcb --default-repo=gcr.io/microservices-lcbo-final-demo2

