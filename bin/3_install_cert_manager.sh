#!/bin/bash

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"
CERT_MANAGER_VERSION=1.5.3

kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v${CERT_MANAGER_VERSION}/cert-manager.yaml
