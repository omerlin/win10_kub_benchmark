#!/bin/bash
set -e
bash ./checkEnv.sh

curl -H "X-Warp10-Token:${WRITE_TOKEN}" "${WARP_URL}/delete?deleteall&selector=K8S_BENCH%7B%7D"  

rm -rf ${SYNC_FILE}
(sleep 600; touch ${SYNC_FILE}) &

for i in $(seq 1 2); do
  nohup bash ./measure.sh ./randomFetch.sh > fetch_${i}.log & 
  nohup bash ./measure.sh ./randomMacro.sh > macro_${i}.log & 
done


