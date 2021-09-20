#!/bin/sh

declare CLUSTER=agocd.local
declare USERNAME=admin
declare PASSWORD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
argocd login argocd.local --username ${USERNAME} --password ${PASSWORD}

