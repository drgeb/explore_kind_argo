#!/bin/sh

kubeseal --format yaml <secret.yaml >sealedsecret.yaml

cat sealedsecret.yaml
