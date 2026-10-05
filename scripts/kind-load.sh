#!/usr/bin/env bash
# Carga una imagen local en los nodos de kind.
# Sustituye a `kind load docker-image`, que falla con Docker Desktop cuando usa el
# almacén de imágenes de containerd (error "ctr: content digest sha256:... not found").
# Uso: ./scripts/kind-load.sh imagen:tag [cluster]      (cluster por defecto: curso)
set -euo pipefail
IMG="${1:?Uso: $0 imagen:tag [cluster]}"
CLUSTER="${2:-curso}"

PLATFORM="$(docker image inspect "$IMG" --format '{{.Os}}/{{.Architecture}}')"
TAR="$(mktemp)"
trap 'rm -f "$TAR"' EXIT

echo ">> Exportando $IMG ($PLATFORM)"
docker save --platform "$PLATFORM" "$IMG" -o "$TAR"
echo ">> Importando en el cluster '$CLUSTER'"
kind load image-archive "$TAR" --name "$CLUSTER"
