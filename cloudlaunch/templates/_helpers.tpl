{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cloudlaunch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudlaunch.fullname" -}}
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
{{- define "cloudlaunch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cloudlaunchServer.name" -}}
{{- if .Values.cloudlaunchServer -}}
{{- default "cloudlaunchServer" .Values.cloudlaunchServer.nameOverride | trunc 63 | trimSuffix "-" | lower -}}
{{- else -}}
{{- printf "cloudlaunchServer" | trunc 63 | trimSuffix "-" | lower -}} 
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudlaunchServer.fullname" -}}
{{- $name := "cloudlaunchServer" -}}
{{- if .Values.cloudlaunchServer -}}
{{- if .Values.cloudlaunchServer.fullnameOverride -}}
{{- .Values.cloudlaunchServer.fullnameOverride | trunc 63 | trimSuffix "-" | lower -}}
{{- else -}}
{{- $name := default "cloudlaunchServer" .Values.cloudlaunchServer.nameOverride -}}
{{- end -}}
{{- end -}}
{{- if contains $name .Release.Name -}}
{{- $name | trunc 63 | trimSuffix "-" | lower -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" | lower -}}
{{- end -}}
{{- end -}}

