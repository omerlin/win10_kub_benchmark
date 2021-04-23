#!/bin/bash
set -e
bash ./checkEnv.sh
gtsDir=$(cd $(dirname $0) && pwd)/${GTS_DIR}
for gts in gts/${1}*.gts; do 
    curl -H "X-Warp10-Token:${WRITE_TOKEN}" -H 'Transfer-Encoding: chunked' --data-binary @${gts} ${WARP_URL}/update > /dev/null 
    echo "$gts injected"
done

