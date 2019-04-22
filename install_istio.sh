#!/usr/bin/env bash

export ISTIO_VERSION=1.1.3

echo "download istio"
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -

echo "change directory"
cd istio-${ISTIO_VERSION}/

echo "add istio to the path"
export PATH=${PWD}/bin:$PATH

echo "install istio - this might take a moment..."
helm install install/kubernetes/helm/istio \
    --name istio \
    --tls \
    --namespace istio-system \
	--set grafana.enabled=true \
	--set grafana.persist=false \
	--set grafana.storageClassName="" \
	--set servicegraph.enabled=true \
	--set tracing.enabled=true \
	--set kiali.enabled=true

echo "------------------------------------"
echo "Istio install is now complete"
