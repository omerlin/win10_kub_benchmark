#!/bin/bash
if [ $# -ne 1 ] ; then
  echo missing label A/B/C
  exit
fi
if [ ! -f ./testMod${1}.mc2 ] ; then
  echo ./testMod${1}.mc2 not found
  exit
fi
POD=$(kubectl -n warpdemo get pod -o custom-columns=:metadata.name)
tokens=$(kubectl -n warpdemo exec -ti $POD -- cat /data/warp10/etc/initial.tokens)
readToken=$(echo $tokens | sed -e 's/.*{"read":{"token":"//g' -e 's/".*//g')
sed "s/readToken/$readToken/g" ./testMod${1}.mc2 | curl -i -T - -H 'Transfer-Encoding: chunked' 'http://127.0.0.1:31080/warp10/api/v0/exec'
