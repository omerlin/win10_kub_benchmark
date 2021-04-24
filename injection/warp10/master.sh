#!/bin/bash

vars="testName nbProcess fetch macro"

duration=3600
nbProcess=3
fetch=true
macro=true
help=false
testName="undefined"

for arg in $* ; do
  argName=$(echo ${arg} | sed 's/--//g' | cut -f1 -d=)
  argValue=$(echo $arg | sed 's/--//g' | cut -f2 -d=)
  echo ${vars} | grep ${argName} >/dev/null && export ${argName}=${argValue}
done

if [ ${help} ] ; then
  echo "Usage : master.sh <--testName='testName'> <--nbProcess=X> <--fetch=true|false> <--macro=true|false> <--duration=SSSS>"	
  exit 0
fi
set -e
bash ./checkEnv.sh

TEST_NAME=${testName}_${duration}_${nbProcess}
${fetch} && TEST_NAME=${TEST_NAME}_fetch
${macro} && TEST_NAME=${TEST_NAME}_macro

export TEST_NAME

# Kill pending sleep
(ps | grep -v grep | grep sleep ) && (echo "there are pending sleep"; exit 1)

# Delete the bench TS
curl -H "X-Warp10-Token:${WRITE_TOKEN}" "${WARP_URL}/delete?deleteall&selector=K8S_BENCH%7B%7D"  

rm -rf ${SYNC_FILE}
(sleep ${duration}; touch ${SYNC_FILE}) &

for i in $(seq 1 ${nbProcess}); do
  ${fetch} && (nohup bash ./measure.sh ./randomFetch.sh > fetch_${i}.log &)
  ${macro} && (nohup bash ./measure.sh ./randomMacro.sh > macro_${i}.log &) 
done


