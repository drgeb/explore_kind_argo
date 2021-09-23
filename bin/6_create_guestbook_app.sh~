#!/bin/bash

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"
NAMESPACE=argocd

kubectl get pods -n ${NAMESPACE} -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
