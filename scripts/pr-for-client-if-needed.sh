#!/bin/bash

# android repositoryの取得
HASH=$(git rev-parse --short HEAD)
mkdir ~/android
cd ~/android
git clone git@github.com:kgmyshin/swagger-auto-android-sample.git
cd swagger-auto-android-sample

#差分チェック TODO: パスを正しく
wget https://kgmyshin.github.io/swagger-auto-server-sample/swagger.json swagger.json
DIFF_COUNT=$(diff swagger.json ./app/scripts/swagger.json | wc -l)
echo $DIFF_COUNT
if [ $DIFF_COUNT -eq 0 ]; then
  echo "更新なし"
  exit 0
fi
echo "更新あり"
rm swagger.json

# HUBコマンドセットアップ
export HUB_VERSION=2.2.9
mkdir -p ~/bin/$HUB_VERSION
if [[ ! -e ~/bin/${HUB_VERSION}/hub ]]; then
  wget --no-verbose https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz -O h.tgz && tar xzf h.tgz && mv hub-linux-amd64-${HUB_VERSION}/bin/hub ~/bin/${HUB_VERSION}/;
fi
export PATH=~/bin/$HUB_VERSION/:$PATH
git config --global user.name "kgmyshin"
git config --global user.email "kgmyshin82@gmai.com"

# 更新
git checkout -b pojo_update_$HASH
./gradlew app:updateJson

# commit, push and pull-request
cd app
git add .
git commit -m "update pojo"
git push origin pojo_update_$HASH
hub pull-request -m "ref kgmyshin/swagger-auto-android-sample/commit/$HASH"