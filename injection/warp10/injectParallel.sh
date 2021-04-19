#!/bin/bash
currentDir=$(cd $(dirname $0) && pwd)
for i in $(seq 8 9) ; do
  nohup $currentDir/injectGTS.sh $i > nohup$i.out 2>&1 &
  echo $i
done
