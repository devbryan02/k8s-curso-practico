#!/usr/bin/env bash
# Despliega TODO el stack desde cero con YAMLs (sin Helm).
# Uso: ./15-proyecto-final/deploy-all.sh   (desde la raíz del curso)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== 1/6 Cluster + ingress =="
./scripts/up.sh

echo "== 2/6 Namespace + bases de datos =="
kubectl apply -f 06-persistencia-bases-de-datos/k8s/
kubectl rollout status sts/mysql -n dev --timeout=300s
kubectl rollout status sts/postgres -n dev --timeout=300s

echo "== 3/6 Keycloak =="
kubectl apply -f 08-keycloak/k8s/
kubectl rollout status deploy/keycloak -n dev --timeout=400s

echo "== 4/6 Imagen del microservicio =="
docker build -t products-api:1.0.0 09-microservicio-spring/app
kind load docker-image products-api:1.0.0 --name curso

echo "== 5/6 Microservicio =="
kubectl apply -f 09-microservicio-spring/k8s/
kubectl rollout status deploy/products-api -n dev --timeout=300s

echo "== 6/6 Smoke test =="
curl -fsS http://api.localtest.me/api/public/ping && echo
TOKEN=$(curl -fsS -X POST http://keycloak.localtest.me/realms/curso/protocol/openid-connect/token \
  -d grant_type=password -d client_id=curso-client -d username=alice -d password=alice123 | jq -r .access_token)
curl -fsS -H "Authorization: Bearer $TOKEN" http://api.localtest.me/api/whoami && echo
echo "OK"
