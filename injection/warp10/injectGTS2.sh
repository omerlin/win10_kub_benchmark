#!/bin/bash
set -e
curl -H "X-Warp10-Token:${WRITE_TOKEN}" -H 'Transfer-Encoding: chunked' --data-binary @${1} ${WARP_URL}/update > /dev/null 
echo "${1} injected"

