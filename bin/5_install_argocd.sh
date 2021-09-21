#!/bin/bash

PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
APP_DIR="$(cd "${PROG_DIR}/.." 2>/dev/null 1>&2 && pwd)"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Service Type Load Balancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Ingress
kubectl apply -f ${APP_DIR}/infra/argocd/ingress.yaml

# Port Forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Obtain password stored in clear text
declare NAME=argocd.local
declare USERNAME=admin
declare PASSWORD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd login ${NAME} --username ${USERNAME} --password ${PASSWORD}

# Register A Cluster To Deploy Apps To (Optional)
declare CLUSTER=`kubectl config get-contexts -o name`
argocd cluster add ${CLUSTER}

# Create An Application From A Git Repository
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

# Sync (Deploy) The Application
argocd app get guestbook