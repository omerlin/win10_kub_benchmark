#!/bin/bash
POD=$(kubectl -n warpdemo get pod -o custom-columns=:metadata.name)
tokens=$(kubectl -n warpdemo exec -ti $POD -- cat /data/warp10/etc/initial.tokens)
writeToken=$(echo $tokens | sed -e 's/.*"write":{"token":"//g' -e 's/".*//g')
gtsDir=$(cd $(dirname $0) && pwd)/gts
for gts in gts/${1}*.gts; do 
    cat $gts | curl -H "X-Warp10-Token:$writeToken" -H 'Transfer-Encoding: chunked' --data-binary @- 'http://127.0.0.1:31080/warp10/api/v0/update' 
    echo "$gts injected"
done

