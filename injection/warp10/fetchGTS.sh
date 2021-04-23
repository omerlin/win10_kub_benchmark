#!/bin/bash
set -e
bash ./checkEnv.sh

vars="silent start stop vol tag"

start=0
stop=999999
silent=true
vol=""
tag=""

for arg in $* ; do
  argName=$(echo ${arg} | sed 's/--//g' | cut -f1 -d=)
  argValue=$(echo $arg | sed 's/--//g' | cut -f2 -d=)
  echo ${vars} | grep ${argName} >/dev/null && export ${argName}=${argValue}
done

start="1970-01-01T00:00:00.$(printf '%06d' $start)Z"
stop="1970-01-01T00:00:00.$(printf '%06d' $stop)Z"

command="curl -i -H X-Warp10-Token:${READ_TOKEN} ${WARP_URL}/fetch?start=${start}&stop=${stop}&selector=~POC_${tag}.*%7Bvol~${vol}.*%7D&format=fulltext&dedup=false"
if ${silent} ; then
  ${command} > /dev/null 
else
  echo "Running ${command}" 
  ${command} 
fi

