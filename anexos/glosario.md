# Glosario del curso

Definiciones cortas de todos los términos del curso, en orden alfabético. La última columna enlaza al módulo donde se explica con detalle.

| Término | Definición | Módulo |
|---------|------------|--------|
| **Access mode** | Cómo se monta un volumen: `ReadWriteOnce`, `ReadOnlyMany`, `ReadWriteMany`. | [06](../06-persistencia-bases-de-datos/README.md) |
| **Actuator health groups** | Endpoints `/actuator/health/liveness` y `/readiness` de Spring Boot pensados para las probes de Kubernetes. | [09](../09-microservicio-spring/README.md) |
| **Anotación** | Clave/valor en `metadata.annotations` que ajusta el comportamiento de un controlador (p. ej. ingress-nginx). | [07](../07-ingress/README.md) |
| **Application (ArgoCD)** | CRD que une repo + path + revisión con cluster + namespace. | [12](../12-gitops-argocd/README.md) |
| **appVersion vs version** | En `Chart.yaml`: `version` es la versión del chart; `appVersion`, la de la aplicación que empaqueta. | [10](../10-helm/README.md) |
| **ArgoCD** | Herramienta GitOps que lee Git y reconcilia los recursos del cluster. | [12](../12-gitops-argocd/README.md) |
| **base64** | Codificación de bytes como texto. **No es cifrado**: se revierte con `base64 -d`. | [04](../04-configmaps-secrets/README.md) |
| **Bucle de reconciliación** | Controladores que comparan deseado vs real y actúan para igualarlos. | [Inicio](../README.md) |
| **cgroups v2** | Mecanismo del kernel que limita CPU/memoria; Kubernetes lo usa para aplicar `requests`/`limits`. | [00](../00-preparacion-entorno/README.md) |
| **Chart** | Paquete Helm: `Chart.yaml` + `values.yaml` + `templates/`. | [10](../10-helm/README.md) |
| **Claim** | Dato dentro de un JWT (`iss`, `exp`, `realm_access.roles`…). | [08](../08-keycloak/README.md) |
| **Client (Keycloak)** | Aplicación registrada en un realm que pide tokens (p. ej. `curso-client`). | [08](../08-keycloak/README.md) |
| **Cluster** | Conjunto de nodos gestionados por un control plane común. | [01](../01-cluster-kind/README.md) |
| **ClusterIP** | IP virtual de un Service, solo alcanzable dentro del cluster. | [03](../03-services-dns/README.md) |
| **ConfigMap** | Objeto con pares clave/valor o archivos de configuración **no sensible**. | [04](../04-configmaps-secrets/README.md) |
| **containerd / CRI** | Runtime de contenedores dentro de cada nodo; se inspecciona con `crictl`. | [01](../01-cluster-kind/README.md) |
| **Contexto (kubeconfig)** | Combinación cluster + usuario + namespace en `~/.kube/config` (p. ej. `kind-curso`). | [01](../01-cluster-kind/README.md) |
| **Contexto de Docker** | A qué demonio Docker habla el CLI `docker` (`docker context ls`). | [00](../00-preparacion-entorno/README.md) |
| **Control plane** | Cerebro del cluster: api-server, etcd, scheduler y controller-manager. | [01](../01-cluster-kind/README.md) |
| **CoreDNS** | DNS interno del cluster; resuelve `servicio.namespace.svc.cluster.local`. | [03](../03-services-dns/README.md) |
| **Deployment** | Gestiona ReplicaSets para hacer updates graduales y rollbacks. Lo que usarás para microservicios. | [02](../02-workloads/README.md) |
| **Docker Engine** | Demonio `dockerd` que crea contenedores; vive en Docker Desktop. | [00](../00-preparacion-entorno/README.md) |
| **Drain / cordon** | `cordon`: nodo no programable; `drain`: además desaloja sus pods respetando PDBs. | [13](../13-proyecto-final/README.md) |
| **Drift** | Diferencia entre Git y el cluster (normalmente un cambio manual). | [12](../12-gitops-argocd/README.md) |
| **Endpoints / EndpointSlice** | Lista de IP:puerto de los Pods *Ready* que coinciden con el selector de un Service. | [03](../03-services-dns/README.md) |
| **envFrom** | Carga todas las claves de un ConfigMap/Secret como variables de entorno. | [04](../04-configmaps-secrets/README.md) |
| **Estado deseado / estado real** | Lo declarado en YAML (guardado en etcd) frente a lo que de verdad corre. | [Inicio](../README.md) |
| **etcd** | Base de datos clave-valor con el estado de todos los objetos del cluster. | [01](../01-cluster-kind/README.md) |
| **GitOps** | Git guarda el estado deseado; un agente en el cluster lo aplica y vigila. | [12](../12-gitops-argocd/README.md) |
| **Graceful shutdown** | Ante SIGTERM, la app termina las peticiones en curso antes de parar. | [09](../09-microservicio-spring/README.md) |
| **Grafana** | Dashboards que consultan Prometheus con PromQL; no guarda métricas. | [11](../11-observabilidad/README.md) |
| **Headless Service** | Service con `clusterIP: None`: no balancea, el DNS devuelve las IPs de los Pods. | [03](../03-services-dns/README.md), [06](../06-persistencia-bases-de-datos/README.md) |
| **Helm** | Gestor de paquetes (charts) de Kubernetes. | [10](../10-helm/README.md) |
| **_helpers.tpl** | Funciones con nombre (`define`) reutilizables con `include`; no genera objetos. | [10](../10-helm/README.md) |
| **hostPort** | Expone un puerto del contenedor en la IP del nodo (así ingress-nginx escucha en 80/443 del nodo kind). | [07](../07-ingress/README.md) |
| **HPA (HorizontalPodAutoscaler)** | Ajusta `replicas` según una métrica (p. ej. % de CPU respecto a `requests.cpu`). | [11](../11-observabilidad/README.md) |
| **IdP (Identity Provider)** | Servidor que gestiona usuarios y emite credenciales de identidad (Keycloak). | [08](../08-keycloak/README.md) |
| **immutable** | Marca un ConfigMap/Secret como no editable; evita cambios accidentales. | [04](../04-configmaps-secrets/README.md) |
| **Ingress** | Reglas HTTP(S) host/path → Service. Por sí solo es solo configuración. | [07](../07-ingress/README.md) |
| **Ingress Controller** | Proxy (ingress-nginx) que lee los Ingress y enruta el tráfico real. | [07](../07-ingress/README.md) |
| **IngressClass** | Indica qué controller atiende un Ingress (`ingressClassName: nginx`). | [07](../07-ingress/README.md) |
| **jwk-set-uri** | URL del JWKS de la que Spring descarga las claves para validar tokens. | [09](../09-microservicio-spring/README.md) |
| **JWKS** | Conjunto de claves públicas del realm para verificar la firma de los JWT. | [08](../08-keycloak/README.md) |
| **JWT** | Token `header.payload.firma` en Base64URL que transporta claims. | [08](../08-keycloak/README.md) |
| **kind** | *Kubernetes IN Docker*: cada nodo del cluster es un contenedor Docker. | [00](../00-preparacion-entorno/README.md), [01](../01-cluster-kind/README.md) |
| **kind load docker-image** | Copia una imagen del Docker local a los nodos kind, sin registry. | [09](../09-microservicio-spring/README.md) |
| **kube-apiserver** | Única puerta de entrada al cluster para kubectl, kubelet y controladores. | [01](../01-cluster-kind/README.md) |
| **kube-proxy** | Agente de cada nodo que programa reglas iptables/IPVS para las ClusterIP. | [03](../03-services-dns/README.md) |
| **kubectl** | CLI de la API de Kubernetes; lee el destino de `~/.kube/config`. | [00](../00-preparacion-entorno/README.md) |
| **kubelet** | Agente de cada nodo que arranca los contenedores de sus Pods y ejecuta las probes. | [01](../01-cluster-kind/README.md) |
| **Kubernetes** | Orquestador de contenedores que hace que el estado real coincida con el deseado que declaras. | [Inicio](../README.md) |
| **Labels y selector** | Etiquetas clave=valor con las que controladores y Services encuentran sus Pods. | [02](../02-workloads/README.md) |
| **LimitRange** | Valores por defecto y mín./máx. de recursos por contenedor en un namespace. | [05](../05-rbac-seguridad/README.md) |
| **MaxRAMPercentage** | Flag de la JVM que dimensiona el heap como % del límite de memoria del contenedor. | [09](../09-microservicio-spring/README.md) |
| **metrics-server** | Recoge CPU/RAM de los kubelets (sin histórico); lo usan `kubectl top` y el HPA. | [11](../11-observabilidad/README.md) |
| **Micrometer / Actuator** | Exponen métricas JVM y HTTP de Spring Boot en `/actuator/prometheus`. | [11](../11-observabilidad/README.md) |
| **Multi-stage build** | Dockerfile con etapa de compilación (JDK+Maven) y etapa runtime (JRE): imagen más pequeña. | [09](../09-microservicio-spring/README.md) |
| **Namespace** | Carpeta lógica del cluster; unidad de permisos y cuotas. No aísla la red por sí solo. | [05](../05-rbac-seguridad/README.md) |
| **NetworkPolicy** | Firewall entre pods por labels; requiere un CNI que la implemente (Calico, Cilium; kindnet no). | [13](../13-proyecto-final/README.md) |
| **Nodo** | Máquina (en kind, contenedor) donde corren Pods; control-plane o worker. | [01](../01-cluster-kind/README.md) |
| **OAuth2** | Estándar de autorización: cómo un cliente obtiene un access token para llamar a una API. | [08](../08-keycloak/README.md) |
| **Observabilidad** | Saber qué pasa dentro del sistema por sus salidas: logs, métricas y trazas. | [11](../11-observabilidad/README.md) |
| **OIDC (OpenID Connect)** | Capa sobre OAuth2 que añade identidad (id_token, `.well-known`, claims estándar). | [08](../08-keycloak/README.md) |
| **OOMKilled** | Contenedor matado por superar `limits.memory`. | [02](../02-workloads/README.md) |
| **PersistentVolume (PV)** | Almacenamiento real del cluster, independiente del ciclo de vida del Pod. | [06](../06-persistencia-bases-de-datos/README.md) |
| **PersistentVolumeClaim (PVC)** | Petición de almacenamiento de una app ("1Gi, RWO") que se enlaza a un PV. | [06](../06-persistencia-bases-de-datos/README.md) |
| **Pod** | Unidad mínima: 1+ contenedores que comparten IP y volúmenes. Efímero. | [02](../02-workloads/README.md) |
| **PodDisruptionBudget (PDB)** | Limita cuántos pods de una app pueden caer a la vez en interrupciones voluntarias. | [13](../13-proyecto-final/README.md) |
| **port / targetPort** | Puerto del Service vs puerto del contenedor al que reenvía. | [03](../03-services-dns/README.md) |
| **port-forward** | Túnel temporal de kubectl a un Pod/Service, solo para depurar. | [03](../03-services-dns/README.md) |
| **Probe** | Chequeo periódico del kubelet: *startup* (¿arrancó?), *readiness* (¿recibe tráfico?), *liveness* (¿está vivo?). | [02](../02-workloads/README.md) |
| **Prometheus** | Base de datos de series temporales que hace *scrape* HTTP de métricas. | [11](../11-observabilidad/README.md) |
| **Prometheus Operator** | Gestiona Prometheus mediante CRDs (`ServiceMonitor`, `PrometheusRule`). | [11](../11-observabilidad/README.md) |
| **Provisioner** | Componente que crea el disco real para un PVC (en kind: `rancher.io/local-path`). | [06](../06-persistencia-bases-de-datos/README.md) |
| **Prune** | ArgoCD borra del cluster lo que ya no está en Git. | [12](../12-gitops-argocd/README.md) |
| **Pull vs push** | GitOps: el cluster tira de Git (pull). CI clásico: el pipeline empuja con kubectl/helm (push). | [12](../12-gitops-argocd/README.md) |
| **Realm** | Espacio aislado de Keycloak con sus usuarios, roles y clientes. | [08](../08-keycloak/README.md) |
| **Release** | Instalación concreta de un chart, con nombre, en un namespace. | [10](../10-helm/README.md) |
| **Render** | Convertir templates + values en manifests finales (`helm template`). | [10](../10-helm/README.md) |
| **ReplicaSet** | Controlador que mantiene N Pods iguales; lo crea el Deployment. | [02](../02-workloads/README.md) |
| **requests / limits** | Lo que el scheduler reserva para un contenedor / el tope que aplica el kernel. | [02](../02-workloads/README.md) |
| **Resource Server** | API (Spring Security) que solo acepta peticiones con un Bearer token válido. | [09](../09-microservicio-spring/README.md) |
| **ResourceQuota** | Tope total de recursos (CPU, memoria, nº de pods) de un namespace. | [05](../05-rbac-seguridad/README.md) |
| **Revision** | Versión numerada de un release (cada install/upgrade/rollback); permite volver atrás. | [10](../10-helm/README.md) |
| **Role / ClusterRole** | Conjunto de permisos (verbs sobre recursos) en un namespace / en todo el cluster. | [05](../05-rbac-seguridad/README.md) |
| **RoleBinding / ClusterRoleBinding** | Une un *subject* (usuario, grupo o ServiceAccount) con un Role/ClusterRole. | [05](../05-rbac-seguridad/README.md) |
| **Rolling update** | Reemplazo gradual de Pods controlado por `maxSurge` y `maxUnavailable`. | [02](../02-workloads/README.md) |
| **Secret** | Como un ConfigMap pero para datos sensibles; guardado en base64 (no cifrado). | [04](../04-configmaps-secrets/README.md) |
| **secretKeyRef / configMapKeyRef** | Carga una sola clave de un Secret/ConfigMap como variable de entorno. | [04](../04-configmaps-secrets/README.md) |
| **securityContext** | Ajustes de seguridad del Pod/contenedor: usuario, capabilities, FS de solo lectura, seccomp. | [05](../05-rbac-seguridad/README.md) |
| **Self-heal** | ArgoCD revierte automáticamente el drift. | [12](../12-gitops-argocd/README.md) |
| **Service** | Nombre e IP virtual estables delante de un grupo de Pods elegidos por selector. | [03](../03-services-dns/README.md) |
| **ServiceAccount** | Identidad de un Pod frente al API server. | [05](../05-rbac-seguridad/README.md) |
| **ServiceMonitor** | CRD que dice a qué Services (por label), puerto y path hacer scrape. | [11](../11-observabilidad/README.md) |
| **Smoke test** | Prueba mínima tras un despliegue para confirmar que lo básico responde. | [13](../13-proyecto-final/README.md) |
| **StatefulSet** | Controlador para apps con estado: nombre estable (`mysql-0`) y un PVC propio por Pod. | [06](../06-persistencia-bases-de-datos/README.md) |
| **StorageClass** | Plantilla que define cómo crear PVs bajo demanda. | [06](../06-persistencia-bases-de-datos/README.md) |
| **stringData** | Campo de un Secret en texto plano; la API lo convierte a base64 en `data`. | [04](../04-configmaps-secrets/README.md) |
| **Sync** | Aplicar al cluster lo que hay en Git. | [12](../12-gitops-argocd/README.md) |
| **Template (Helm)** | YAML de Kubernetes con huecos Go template (`{{ .Values.x }}`). | [10](../10-helm/README.md) |
| **TLS Secret** | Secret `kubernetes.io/tls` con certificado y clave para servir HTTPS. | [07](../07-ingress/README.md) |
| **Values** | Parámetros de los templates. Prioridad: `values.yaml` < `-f` < `--set`. | [10](../10-helm/README.md) |
| **Verb** | Acción sobre la API: get, list, watch, create, update, patch, delete. | [05](../05-rbac-seguridad/README.md) |
| **volumeClaimTemplates** | Plantilla de PVC de un StatefulSet: un PVC por réplica (`data-mysql-0`…). | [06](../06-persistencia-bases-de-datos/README.md) |
