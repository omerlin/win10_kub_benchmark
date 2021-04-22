#!/bin/bash
gtsDir=$(cd $(dirname $0) && pwd)/${GTS_DIR}
for gts in gts/*.gts; do 
    cat ${gts} | curl -H "X-Warp10-Token:${WRITE_TOKEN}" -H 'Transfer-Encoding: chunked' --data-binary @- ${WARP_URL}/update 
    echo "${gts} injected"
done

