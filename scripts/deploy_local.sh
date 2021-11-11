#!/usr/bin/env bash
set -e
set -x

namespace=$1
echo "namespace is $namespace"

function create_cluster() {
    # Create K8s cluster if it does not exist
    export KUBECONFIG="$HOME/.kube/$namespace.config.local"
    kind delete cluster --name "$namespace"
    if ! kind get clusters | grep "${namespace}" &> /dev/null; then
       if ! [ -f "$KUBECONFIG" ]; then
         echo "Creating kubeconfig for local env"
         touch "$KUBECONFIG"
       fi
        kind create cluster \
        --kubeconfig "$KUBECONFIG" \
    		--name "$namespace" \
    		--image "kindest/node:v1.22.2" \
        --config "configs/create-cluster.yaml"
        # Check cluster info
        chmod 600 "$KUBECONFIG"
        kubectl cluster-info --context "kind-$namespace"
        # Install ingress
        kubectl apply -f echo/service-accounts.yaml
        kubectl apply -f echo/foo.yaml
        kubectl apply -f echo/bar.yaml
        kubectl apply -f configs/ingress.yaml
#        sleep 15
#        echo "Waiting for Ingress controller to be ready..."
#        kubectl wait --namespace ingress-nginx \
#        --for=condition=ready pod \
#        --selector=app.kubernetes.io/component=controller \
#        --timeout=90s
#        sleep 15
    fi
}

create_cluster
