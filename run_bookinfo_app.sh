echo "change directory"
export ISTIO_VERSION=1.0.0
cd istio-${ISTIO_VERSION}/

echo "launch bookinfo sample on gke"

kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml  
sleep 10

echo "add in the ingress"
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml 
kubectl get gateway
