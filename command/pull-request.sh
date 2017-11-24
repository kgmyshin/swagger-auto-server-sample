HASH=$(git rev-parse --short HEAD)
mkdir ~/android
cd ~/android
git clone git@github.com:kgmyshin/swagger-auto-android-sample.git
cd swagger-auto-android-sample
# 差分があったらpull-request
echo aa >> a.txt
hub pull-request -b master -h "pojo_update_$HASH" -m "ref kgmyshin/swagger-auto-android-sample/commit/$HASH" || true