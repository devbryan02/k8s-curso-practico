#!/usr/bin/env bash
# Crea el cluster 'curso' e instala ingress-nginx.
# Uso: ./scripts/up.sh                 (CNI por defecto de kind)
#      CNI=calico ./scripts/up.sh      (con Calico: necesario para el módulo 13, NetworkPolicies)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CALICO_VERSION="v3.28.2"
CNI="${CNI:-default}"

if kind get clusters | grep -qx curso; then
  echo ">> El cluster 'curso' ya existe"
else
  if [ "$CNI" = "calico" ]; then
    kind create cluster --config "$ROOT/01-cluster-kind/kind-config-calico.yaml"
    echo ">> Instalando Calico $CALICO_VERSION (CNI con soporte de NetworkPolicy)"
    kubectl apply -f "https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/calico.yaml"
    kubectl rollout status daemonset/calico-node -n kube-system --timeout=300s
    kubectl wait --for=condition=Ready nodes --all --timeout=300s
  else
    kind create cluster --config "$ROOT/01-cluster-kind/kind-config.yaml"
  fi
fi

echo ">> Instalando ingress-nginx (manifiesto para kind)"
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
echo ">> Listo. Contexto: $(kubectl config current-context)"
