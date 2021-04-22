#!/bin/bash
set -e
bash checkEnv.sh

silent=false
if [ "$1" == "--silent" ] ; then
  silent=true
  shift
fi

nbTS=$1
vol=$2
tag=$3
if [ $# -eq 0 ] ; then
  >&2 echo "Usage : fetchGTS.sh <--silent> numberOfTimeStamps <vol> <tag>"
  exit 1
fi
if ${silent} ; then
  curl -i -H "X-Warp10-Token: ${READ_TOKEN}" "${WARP_URL}/fetch?now=${FUTURE_DATE}&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" > /dev/null 
else
  curl -i -H "X-Warp10-Token: ${READ_TOKEN}" "${WARP_URL}/fetch?now=${FUTURE_DATE}&timespan=-${nbTS}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false" 
fi

