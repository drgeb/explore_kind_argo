#!/bin/sh

./bin/1_setup_kind.sh
./bin/2_add_ingress_to_cluster.sh
./bin/3_install_cert_manager.sh
./bin/4_apply_certificate_issuer.sh
./bin/5_install_argocd.sh
./bin/6_get_name_argo_server_docker.sh
