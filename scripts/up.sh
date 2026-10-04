#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if kind get clusters | grep -qx curso; then
  echo ">> El cluster 'curso' ya existe"
else
  kind create cluster --config "$ROOT/01-cluster-kind/kind-config.yaml"
fi

echo ">> Instalando ingress-nginx (manifiesto para kind)"
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
echo ">> Listo. Contexto: $(kubectl config current-context)"
