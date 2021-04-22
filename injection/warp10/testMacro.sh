#!/bin/bash
if [ $# -ne 1 ] ; then
  echo missing label A/B/C
  exit
fi
if [ ! -f ./testMod${1}.mc2 ] ; then
  echo ./testMod${1}.mc2 not found
  exit
fi
sed "s/readToken/${READ_TOKEN}/g" ./testMod${1}.mc2 | curl -i -T - -H 'Transfer-Encoding: chunked' ${WARP_URL}/exec
