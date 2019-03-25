{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cloudlaunch-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudlaunch-server.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloudlaunch-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rabbitmq.fullname" -}}
{{- printf "%s-%s" .Release.Name "rabbitmq" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "cloudlaunch-server.envvars" }}
            - name: CELERY_BROKER_URL
              value: amqp://{{ .Values.rabbitmq.rabbitmqUsername }}:{{ .Values.rabbitmq.rabbitmqPassword }}@{{ template "rabbitmq.fullname" . }}:5672/
            - name: DJANGO_SETTINGS_MODULE
              value: {{ .Values.django_settings_module | default "cloudlaunchserver.settings_prod" | quote }}
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_ENGINE
              value: postgresql_psycopg2
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_NAME
              value: {{ .Values.postgresql.postgresqlDatabase | default "cloudlaunch" | quote }}
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_USER
              value: {{ .Values.postgresql.postgresqlUsername | default "cloudlaunch" | quote }}
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_HOST
              value: {{ template "postgresql.fullname" . }}
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_PORT
              value: {{ .Values.postgresql.service.port | default 5432 | quote }}
            - name: {{ .Values.env_prefix | default "CLOUDLAUNCH" | upper }}_DB_PASSWORD
              value: {{ .Values.postgresql.postgresqlPassword | quote }}
            {{- if not (eq .Values.ingress.path "/") }}
            - name: CLOUDLAUNCH_PATH_PREFIX
              value: {{ .Values.ingress.path | quote }}
            {{- end }}
{{- end }}

{{/*
Create a template for expanding a section into env vars
*/}}
{{- define "cloudlaunch-server.extra_envvars" -}}
{{- range $key, $val := . }}
{{- if $val }}
            - name: {{ $key | upper }}
              value: {{ quote $val }}
{{- end }}
{{- end }}
{{- end -}}
