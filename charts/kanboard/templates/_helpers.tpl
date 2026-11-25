{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kanboard.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Name of the CloudNativePG Cluster created when cnpg.enabled is true.
*/}}
{{- define "kanboard.cnpgClusterName" -}}
{{- printf "%s-db" (include "kanboard.name" .) | trunc 50 | trimSuffix "-" }}
{{- end }}

{{/*
Fail rendering on conflicting values.
*/}}
{{- define "kanboard.validate" -}}
{{- if .Values.cnpg.enabled }}
{{- $db := .Values.config.database }}
{{- $set := list }}
{{- range $key := list "driver" "hostname" "port" "name" "username" }}
{{- $value := index $db $key }}
{{- if not (or (kindIs "invalid" $value) (eq (toString $value) "")) }}
{{- $set = append $set (printf "config.database.%s" $key) }}
{{- end }}
{{- end }}
{{- if $db.existingSecret.name }}
{{- $set = append $set "config.database.existingSecret.name" }}
{{- end }}
{{- if $set }}
{{- fail (printf "cnpg.enabled is true, so the external database settings must be empty, but these are set: %s" (join ", " $set)) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Render a single env var from (list NAME value). Null or empty values are
skipped so that Kanboard's upstream defaults apply; booleans render as "true"/"false".
*/}}
{{- define "kanboard.envVar" -}}
{{- $name := index . 0 }}
{{- $value := index . 1 }}
{{- if not (or (kindIs "invalid" $value) (eq (toString $value) "")) }}
- name: {{ $name }}
  value: {{ toString $value | quote }}
{{- end }}
{{- end }}

{{/*
Render an env var from an existing Secret, given (list NAME existingSecret).
Skipped when existingSecret.name is not set.
*/}}
{{- define "kanboard.envSecret" -}}
{{- $name := index . 0 }}
{{- $secret := index . 1 }}
{{- if $secret.name }}
- name: {{ $name }}
  valueFrom:
    secretKeyRef:
      name: {{ $secret.name }}
      key: {{ $secret.key | default "password" }}
{{- end }}
{{- end }}

{{/*
Database settings: .Values.config.database -> DB_*
*/}}
{{- define "kanboard.config.database" -}}
{{- if .Values.cnpg.enabled }}
{{- $cluster := include "kanboard.cnpgClusterName" . }}
{{- include "kanboard.envVar" (list "DB_DRIVER" "postgres") }}
{{- include "kanboard.envVar" (list "DB_HOSTNAME" (printf "%s-rw" $cluster)) }}
{{- include "kanboard.envVar" (list "DB_PORT" 5432) }}
{{- include "kanboard.envVar" (list "DB_NAME" .Values.cnpg.database) }}
{{- include "kanboard.envSecret" (list "DB_USERNAME" (dict "name" (printf "%s-app" $cluster) "key" "username")) }}
{{- include "kanboard.envSecret" (list "DB_PASSWORD" (dict "name" (printf "%s-app" $cluster) "key" "password")) }}
{{- include "kanboard.envVar" (list "DB_RUN_MIGRATIONS" .Values.config.database.runMigrations) }}
{{- else }}
{{- with .Values.config.database }}
{{- include "kanboard.envVar" (list "DB_DRIVER" .driver) }}
{{- include "kanboard.envVar" (list "DB_HOSTNAME" .hostname) }}
{{- include "kanboard.envVar" (list "DB_PORT" .port) }}
{{- include "kanboard.envVar" (list "DB_NAME" .name) }}
{{- include "kanboard.envVar" (list "DB_USERNAME" .username) }}
{{- include "kanboard.envSecret" (list "DB_PASSWORD" .existingSecret) }}
{{- include "kanboard.envVar" (list "DB_RUN_MIGRATIONS" .runMigrations) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Mail settings: .Values.config.mail -> MAIL_*
*/}}
{{- define "kanboard.config.mail" -}}
{{- with .Values.config.mail }}
{{- include "kanboard.envVar" (list "MAIL_FROM" .from) }}
{{- include "kanboard.envVar" (list "MAIL_TRANSPORT" .transport) }}
{{- with .smtp }}
{{- include "kanboard.envVar" (list "MAIL_SMTP_HOSTNAME" .hostname) }}
{{- include "kanboard.envVar" (list "MAIL_SMTP_PORT" .port) }}
{{- include "kanboard.envVar" (list "MAIL_SMTP_USERNAME" .username) }}
{{- include "kanboard.envSecret" (list "MAIL_SMTP_PASSWORD" .existingSecret) }}
{{- include "kanboard.envVar" (list "MAIL_SMTP_ENCRYPTION" .encryption) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
LDAP settings: .Values.config.ldap -> LDAP_*
*/}}
{{- define "kanboard.config.ldap" -}}
{{- with .Values.config.ldap }}
{{- include "kanboard.envVar" (list "LDAP_AUTH" .enabled) }}
{{- include "kanboard.envVar" (list "LDAP_SERVER" .server) }}
{{- include "kanboard.envVar" (list "LDAP_PORT" .port) }}
{{- include "kanboard.envVar" (list "LDAP_SSL_VERIFY" .sslVerify) }}
{{- include "kanboard.envVar" (list "LDAP_START_TLS" .startTls) }}
{{- include "kanboard.envVar" (list "LDAP_USERNAME_CASE_SENSITIVE" .usernameCaseSensitive) }}
{{- include "kanboard.envVar" (list "LDAP_BIND_TYPE" .bindType) }}
{{- include "kanboard.envVar" (list "LDAP_USERNAME" .username) }}
{{- include "kanboard.envSecret" (list "LDAP_PASSWORD" .existingSecret) }}
{{- include "kanboard.envVar" (list "LDAP_USER_BASE_DN" .userBaseDn) }}
{{- include "kanboard.envVar" (list "LDAP_USER_FILTER" .userFilter) }}
{{- with .userAttributes }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_USERNAME" .username) }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_FULLNAME" .fullname) }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_EMAIL" .email) }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_GROUPS" .groups) }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_PHOTO" .photo) }}
{{- include "kanboard.envVar" (list "LDAP_USER_ATTRIBUTE_LANGUAGE" .language) }}
{{- end }}
{{- include "kanboard.envVar" (list "LDAP_USER_CREATION" .userCreation) }}
{{- include "kanboard.envVar" (list "LDAP_USER_DEFAULT_ROLE_MANAGER" .userDefaultRoleManager) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_ADMIN_DN" .groupAdminDn) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_MANAGER_DN" .groupManagerDn) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_PROVIDER" .groupProvider) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_BASE_DN" .groupBaseDn) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_FILTER" .groupFilter) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_USER_FILTER" .groupUserFilter) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_USER_ATTRIBUTE" .groupUserAttribute) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_ATTRIBUTE_NAME" .groupAttributeName) }}
{{- include "kanboard.envVar" (list "LDAP_GROUP_SYNC" .groupSync) }}
{{- end }}
{{- end }}

{{/*
Reverse proxy authentication: .Values.config.reverseProxy -> REVERSE_PROXY_*
*/}}
{{- define "kanboard.config.reverseProxy" -}}
{{- with .Values.config.reverseProxy }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_AUTH" .enabled) }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_USER_HEADER" .userHeader) }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_EMAIL_HEADER" .emailHeader) }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_FULLNAME_HEADER" .fullnameHeader) }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_DEFAULT_ADMIN" .defaultAdmin) }}
{{- include "kanboard.envVar" (list "REVERSE_PROXY_DEFAULT_DOMAIN" .defaultDomain) }}
{{- end }}
{{- end }}

{{/*
All environment variables rendered from .Values.config.
*/}}
{{- define "kanboard.configEnv" -}}
{{- include "kanboard.config.database" . }}
{{- include "kanboard.config.mail" . }}
{{- include "kanboard.config.ldap" . }}
{{- include "kanboard.config.reverseProxy" . }}
{{- end }}
