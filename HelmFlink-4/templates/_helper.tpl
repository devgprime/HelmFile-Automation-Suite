
  {{- define "mergeFlinkConfig" -}}
  {{- $msName := .Release.Name }}  
  {{- $defaultConfig := index .Values.default ms "spec" "flinkConfiguration" }} 
  {{- $overrideConfig := index .Values $msName "spec" "flinkConfiguration" }}  
  {{- range $key, $value := $defaultConfig }}
    {{ $key }}: {{ coalesce (pluck $key $overrideConfig | first) $value }}
  {{- end }}
{{- end }}


{{- define "mergeJobConfig" -}}
  {{- $msName := .Release.Name }}
  {{- $defaultConfig := index .Values.default $msName "spec" "job" }}
  {{- $overrideConfig := index .Values $msName "spec" "job" }}
  {{- range $key, $value := $defaultConfig }}
  {{ $key }}: {{ coalesce (pluck $key $overrideConfig | first) $value }}
  {{- end }}
{{- end }}

 
