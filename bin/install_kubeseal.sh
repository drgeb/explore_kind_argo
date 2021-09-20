#!/bin/sh

VERSION=$(curl --silent "https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/$VERSION/kubeseal-linux-amd64 -O /usr/local/bin/kubeseal
chmod 755 /usr/local/bin/kubeseal
kubeseal --version

kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/$VERSION/controller.yaml
