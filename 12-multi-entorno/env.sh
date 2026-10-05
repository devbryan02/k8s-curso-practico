#!/usr/bin/env bash
# Levanta un entorno completo: namespace + base (quota, limits, RBAC) + MySQL + products-api.
# Uso: ./12-multi-entorno/env.sh <dev|qa|pre|prod>   (desde la raíz del curso)
set -euo pipefail
ENV="${1:?Uso: $0 <dev|qa|pre|prod>}"
case "$ENV" in dev|qa|pre|prod) ;; *) echo "Entorno desconocido: $ENV" >&2; exit 1;; esac
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== [$ENV] Namespace =="
kubectl create namespace "$ENV" --dry-run=client -o yaml | kubectl apply -f -
kubectl label namespace "$ENV" entorno="$ENV" --overwrite

echo "== [$ENV] Base: quota, limits y RBAC =="
helm upgrade --install baseline 12-multi-entorno/charts/env-baseline -n "$ENV" \
  -f "12-multi-entorno/charts/env-baseline/values-$ENV.yaml"

# dev ya tiene MySQL del módulo 06; los demás entornos necesitan el suyo.
if [ "$ENV" != "dev" ]; then
  echo "== [$ENV] MySQL propio =="
  for f in 10-mysql-secret 11-mysql-statefulset; do
    sed "s/namespace: dev/namespace: $ENV/" "06-persistencia-bases-de-datos/k8s/$f.yaml" | kubectl apply -f -
  done
  kubectl rollout status sts/mysql -n "$ENV" --timeout=300s
fi

echo "== [$ENV] products-api =="
helm upgrade --install products-api 10-helm/charts/products-api -n "$ENV" \
  -f "10-helm/charts/products-api/values-$ENV.yaml" --atomic --timeout 5m

echo "== [$ENV] Listo =="
helm list -n "$ENV"
