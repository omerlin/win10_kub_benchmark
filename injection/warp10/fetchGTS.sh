#!/bin/bash
POD=$(kubectl -n warpdemo get pod -o custom-columns=:metadata.name)
tokens=$(kubectl -n warpdemo exec -ti $POD -- cat /data/warp10/etc/initial.tokens)
readToken=$(echo $tokens | sed -e 's/.*{"read":{"token":"//g' -e 's/".*//g')

nbTS=$1
vol=$2
tag=$3
if [ $# -eq 0 ] ; then
  echo Usage : getchGTS.sh numberOfTimeStamps vol tag
  echo curl -i -H "X-Warp10-Token: $readToken" "http://localhost:31080/warp10/api/v0/fetch?now=2021-04-16T00%3A00%3A00.000Z&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" 
  exit
fi
curl -i -H "X-Warp10-Token: $readToken" "http://localhost:31080/warp10/api/v0/fetch?now=2021-04-16T00%3A00%3A00.000Z&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" 

