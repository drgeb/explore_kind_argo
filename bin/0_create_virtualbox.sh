#!/bin/sh
cp ~/.ssh/config bootstrap/files/host-ubuntu2004.localdomain/config
cp -r ~/.ssh/id_rsa_bb* bootstrap/files/host-ubuntu2004.localdomain/.
cp ~/.ssh/ansible_vault_system_configs bootstrap/files/host-ubuntu2004.localdomain/.