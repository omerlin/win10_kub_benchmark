#!/bin/bash
POD=$(kubectl -n warpdemo get pod -o custom-columns=:metadata.name)
tokens=$(kubectl -n warpdemo exec -ti $POD -- cat /data/warp10/etc/initial.tokens)
writeToken=$(echo $tokens | sed -e 's/.*"write":{"token":"//g' -e 's/".*//g')
startTime=$(date +%s%N)
$@
execTime=$((($(date +%s%N) - $startTime)/1000))
now=$(($(date +%s%N)/1000))
cmd=$1
shift
TS="$now// K8S_BENCH{envir=$BENCH_ENV, host=$(hostname), cmd=$cmd, args=$@} $execTime"
echo $TS | curl -H "X-Warp10-Token:$writeToken" -H 'Transfer-Encoding: chunked' --data-binary @- 'http://127.0.0.1:31080/warp10/api/v0/update' 
