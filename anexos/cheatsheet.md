# Cheatsheet

## Recursos y abreviaturas

| Recurso | Abrev. |
|---------|--------|
| pods | po |
| deployments | deploy |
| replicasets | rs |
| statefulsets | sts |
| services | svc |
| configmaps | cm |
| namespaces | ns |
| persistentvolumeclaims | pvc |
| persistentvolumes | pv |
| ingresses | ing |
| horizontalpodautoscalers | hpa |
| serviceaccounts | sa |

## Plantilla Deployment + Service (Spring Boot)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata: {name: mi-api}
spec:
  replicas: 2
  selector: {matchLabels: {app: mi-api}}
  template:
    metadata: {labels: {app: mi-api}}
    spec:
      containers:
        - name: mi-api
          image: mi-api:1.0.0
          ports: [{name: http, containerPort: 8080}]
          envFrom: [{configMapRef: {name: mi-api-config}}]
          resources:
            requests: {cpu: 200m, memory: 384Mi}
            limits: {memory: 768Mi}
          readinessProbe: {httpGet: {path: /actuator/health/readiness, port: http}}
          livenessProbe:  {httpGet: {path: /actuator/health/liveness,  port: http}}
---
apiVersion: v1
kind: Service
metadata: {name: mi-api}
spec:
  selector: {app: mi-api}
  ports: [{name: http, port: 8080, targetPort: http}]
```

## Helm

```bash
helm create mi-chart
helm lint ./mi-chart
helm template rel ./mi-chart -f values.yaml
helm upgrade --install rel ./mi-chart -n dev --create-namespace --atomic
helm list -A
helm history rel -n dev
helm rollback rel 1 -n dev
helm uninstall rel -n dev
helm get values rel -n dev
```

## kind

```bash
kind create cluster --config kind-config.yaml   # luego instalar Calico (o usar ./scripts/up.sh)
kind get clusters
./scripts/kind-load.sh img:tag        # equivale a `kind load docker-image`, compatible con Docker Desktop reciente
kind export logs ./logs --name curso
kind delete cluster --name curso
```

## Reglas de oro

1. Nunca `latest` en imágenes; en kind además `imagePullPolicy: IfNotPresent`.
2. Siempre `requests` y `limits` (al menos memoria).
3. Siempre readiness y liveness (startupProbe para apps lentas como Spring).
4. Secretos fuera de Git en claro.
5. Verifica el contexto/namespace antes de aplicar.
6. Una app, una responsabilidad: config en ConfigMap/Secret, estado en volúmenes/BD externa.
