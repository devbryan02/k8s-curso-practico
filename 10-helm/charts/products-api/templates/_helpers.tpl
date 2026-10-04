{{- define "products-api.fullname" -}}
{{- .Release.Name -}}
{{- end -}}

{{- define "products-api.labels" -}}
app: {{ include "products-api.fullname" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "products-api.selectorLabels" -}}
app: {{ include "products-api.fullname" . }}
{{- end -}}
