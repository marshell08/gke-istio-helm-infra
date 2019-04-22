echo "launch bookinfo sample on gke"

kubectl create ns bookinfo-dev
kubectl label namespace bookinfo-dev istio-injection=enabled

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
sleep 10

echo "add in the ingress"
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get gateway

echo "checking for gateway completion"
sleep 30
sh samples/check-bookinfo-gateway.sh

echo "if this errors out you can always retry by calling:"
echo "sh samples/check-bookinfo-gateway.sh"

echo "you'll also want to add in the version routing for the samples:"
echo "sh samples/add-bookinfo-version-routing.sh"