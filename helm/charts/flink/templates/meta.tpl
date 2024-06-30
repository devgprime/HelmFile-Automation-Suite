{{/*
== Functions for metadata management

 - meta-name: returns the standard object name for objects we define.
   Usage:
   {{- include "meta.name" (dict "Root" . "Name" "object-name" ) | indent 2 }}
 - meta.metadata: returns the standard set of metadata we add to basically
   any object we define.
   Usage:
   {{- include "meta.metadata" (dict "Root" . "Name" "object-name" ) | indent 2 }}
 - meta.routing: labels for traffic routing between service and deployments.
*/}}
{{- define "meta.name" -}}
{{ template "name.release" .Root }}{{- if .Name }}-{{ .Name }}{{ end }}
{{- end -}}

{{- define "meta.metadata" }}
name: {{ template "meta.name" . }}
{{- include "meta.labels" .Root }}
{{- end -}}

{{- define "meta.labels" }}
labels:
  app: {{ template "name.chart" . }}
  chart: {{ template "name.chartid" . }}
  release: {{ .Release.Name }}
  heritage: {{ .Release.Service }}
{{- end }}

{{- define "meta.pod_labels" }}
app: {{ template "name.chart" . }}
release: {{ .Release.Name }}
routed_via: {{ .Values.routed_via | default .Release.Name }}
{{- end }}

{{- define "meta.selector" }}
matchLabels:
  app: {{ template "name.chart" . }}
  release: {{ .Release.Name }}
{{- end }}

{{- define "meta.pod_annotations" }}
elastic.co/namespace: {{ .Values.elastic_log_namespace }} 
{{- end }}
