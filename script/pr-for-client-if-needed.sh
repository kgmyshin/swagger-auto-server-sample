#!/bin/bash

# android repositoryの取得
HASH=$(git rev-parse --short HEAD)
mkdir ~/android
cd ~/android
git clone git@github.com:kgmyshin/swagger-auto-android-sample.git
cd swagger-auto-android-sample

#差分チェック TODO: パスを正しく
wget https://kgmyshin.github.io/swagger-auto-server-sample/swagger.json newest.json
DIFF_COUNT=$(diff newest.json swagger.json | wc -l)
echo $DIFF_COUNT
if [ $DIFF_COUNT -eq 0 ]; then
  exit 0
fi
rm newst.json

# HUBコマンドセットアップ
export HUB_VERSION=2.2.9
mkdir -p ~/bin/$HUB_VERSION
if [[ ! -e ~/bin/${HUB_VERSION}/hub ]]; then
  wget --no-verbose https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz -O h.tgz && tar xzf h.tgz && mv hub-linux-amd64-${HUB_VERSION}/bin/hub ~/bin/${HUB_VERSION}/;
fi
echo "export PATH=~/bin/$HUB_VERSION/:$PATH" >> $BASH_ENV
git config --global user.name "kgmyshin"
git config --global user.email "kgmyshin82@gmai.com"

# 更新: TODO
git checkout -b pojo_update_$HASH
echo aa >> a.txt

# commit, push and pull-request
git add .
git commit -m "update pojo"
git push origin pojo_update_$HASH
hub pull-request -m "ref kgmyshin/swagger-auto-android-sample/commit/$HASH"