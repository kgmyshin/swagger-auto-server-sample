#!/usr/bin/env bash

# Installing dependencies - AWS CLI
pip install --quiet --upgrade awscli pip

mkdir -p ~/bin/$HUB_VERSION
if [[ ! -e ~/bin/${HUB_VERSION}/hub ]]; then wget --no-verbose https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz -O h.tgz && tar xzf h.tgz && mv hub-linux-amd64-${HUB_VERSION}/bin/hub ~/bin/${HUB_VERSION}/; fi
