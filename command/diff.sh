wget https://kgmyshin.github.io/swagger-auto-server-sample/swagger.json swagger.json
DIFF_COUNT=$(diff a.txt aa.txt | wc -l)

echo $DIFF_COUNT

if [ $DIFF_COUNT -eq 0 ]; then
  echo "diffなし"
else
  echo "diffあり"
fi
