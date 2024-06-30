{{/*
Modulename: name
Version: 1.0
Depends-

== Standard boilerplate safe names for kubernetes

The DNS spec in k8s limits names to 63 chars,
so we do the same for names here.

 - name.chart
   The chart name safely truncated to 63 chars.
   We allow overriding this via .Values.chartName.

 - name.release
   The chart + release name truncated to 63 chars.

 - name.chartid
   chart name + chart version.

 - name.baseurl
   URL for the app port.  Uses name.release as the hostname.


NOTE: The app name is not used in any of these templates.
Because we isolate our applications within k8s namespaces,
these template variables should be unique within any given namespace.
*/}}

{{- define "name.chart" -}}
{{- default .Chart.Name .Values.chartName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "name.release" -}}
{{- $name := default .Chart.Name .Values.chartName -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "name.chartid" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "name.baseurl" -}}
http://{{ template "name.release" . }}:{{ .Values.app.port }}
{{- end -}}