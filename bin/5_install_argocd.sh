#!/bin/bash

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
NAMESPACE=argocd
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"

kubectl create namespace ${NAMESPACE}
kubectl apply -n ${NAMESPACE} -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Service Type Load Balancer
kubectl patch svc argocd-server -n ${NAMESPACE} -p '{"spec": {"type": "LoadBalancer"}}'

# Ingress
kubectl apply -f ${APP_DIR}/infra/argocd/ingress.yaml

# Port Forwarding
# kubectl port-forward svc/argocd-server -n ${NAMESPACE} 8080:443

# Obtain password stored in clear text
declare ARGOCD_SERVER=argocd.local
declare ARGOCD_USERNAME=admin
declare ARGOCD_PASSWORD=`kubectl -n ${NAMESPACE} get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd login ${ARGOCD_SERVER} --username ${ARGOCD_USERNAME} --password ${ARGOCD_PASSWORD} --grpc-web

# Register A Cluster To Deploy Apps To (Optional)
declare CLUSTER=`kubectl config get-contexts -o name`
argocd cluster add ${CLUSTER} --grpc-web

