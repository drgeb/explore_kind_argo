#!/bin/bash

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"

./bin/1_setup_kind.sh
./bin/2_add_ingress_to_cluster.sh
./bin/3_install_cert_manager.sh
./bin/4_apply_certificate_issuer.sh
./bin/5_install_argocd.sh
./bin/6_get_name_argo_server_docker.sh
