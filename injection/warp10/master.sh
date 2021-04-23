#!/bin/bash
set -e
bash checkEnv.sh

rm ${SYNC_FILE}
(sleep 3600; touch ${SYNC_FILE}) &

for i in $(seq 1 2); do
  nohup bash measure.sh randomFetch.sh > fetch${i}.nohup & 
  nohup bash measure.sh randomMacro.sh > macro${i}.nohup & 
done


