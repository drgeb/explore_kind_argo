#!/bin/sh

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"

cp ~/.ssh/config ${APP_DIR}/bootstrap/files/host-ubuntu2004.localdomain/config
cp -r ~/.ssh/id_rsa_bb* ${APP_DIR}/bootstrap/files/host-ubuntu2004.localdomain/.
cp ~/.ssh/ansible_vault_system_configs ${APP_DIR}/bootstrap/files/host-ubuntu2004.localdomain/.