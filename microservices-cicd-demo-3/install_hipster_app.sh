#!/usr/bin/env bash

git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
cd microservices-demo

kubectl label namespace default istio-injection=enabled
kubectl apply -f ./istio-manifests

#skaffold run --default-repo=gcr.io/[PROJECT_ID]
skaffold run -p gcb --default-repo=gcr.io/microservices-lcbo-final-demo2

