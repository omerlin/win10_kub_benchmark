#!/bin/bash

set -e
bash ./checkEnv.sh

start="1970-01-01T00:00:00.000000Z"
stop="2999-01-01T00:00:00.000000Z"

total_cmd=0

workFile=/tmp/tmp1$$
statFile=/tmp/tmp2$$

touch $statFile

for cmd in fetchGTS.sh testMacro.sh ; do
  for tag in A B C ; do
    curl -s -H X-Warp10-Token:${READ_TOKEN} "${WARP_URL}/fetch?start=${start}&stop=${stop}&selector=K8S_BENCH%7Bargs~.*tag%3A${tag}%2Ccmd%3D.%2F${cmd}%7D&format=fulltext&dedup=false" > $workFile
    if [ ! -s $workFile ] ; then
      continue
    fi
    echo Average ${cmd} ${tag} = $(cat $workFile | awk '{ total += $3 } END { print total/NR/1000 }') ms >> $statFile
    total_cmd=$((${total_cmd}+$(wc -l $workFile | cut -d' ' -f1)))
  done
done

cat $statFile
echo "Total commands ${total_cmd}"

rm -f $workFile
rm -f $statFile

