#!/bin/bash

nbTS=$1
vol=$2
tag=$3
if [ $# -eq 0 ] ; then
  echo Usage : fetchGTS.sh numberOfTimeStamps vol tag
  echo curl -i -H "X-Warp10-Token: ${READ_TOKEN}" "${WARP_URL}/fetch?now=${FUTURE_DATE}&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" 
  exit
fi
curl -i -H "X-Warp10-Token: ${READ_TOKEN}" "${WARP_URL}/fetch?now=${FUTURE_DATE}&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" 

