#!/bin/bash
set -e
sh checkEnv.sh
startTime=$(date +%s%N)
$@
execTime=$((($(date +%s%N) - $startTime)/1000))
now=$(($(date +%s%N)/1000))
cmd=$1
shift
TS="$now// K8S_BENCH{envir=$BENCH_ENV, host=$(hostname), cmd=$cmd, args=$@} $execTime"
echo ${TS} | curl -H "X-Warp10-Token:${WRITE_TOKEN}" -H 'Transfer-Encoding: chunked' --data-binary @- ${WARP_URL}/update 
