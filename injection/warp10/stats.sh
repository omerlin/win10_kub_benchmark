#!/bin/bash
set -e
bash ./checkEnv.sh

start=0
stop=999999

start="1970-01-01T00:00:00.$(printf '%06d' $start)Z"
stop="2999-01-01T00:00:00.$(printf '%06d' $stop)Z"

for cmd in fetchGTS.sh testMacro.sh ; do
  for tag in A B C ; do
    curl -i -H X-Warp10-Token:${READ_TOKEN} "${WARP_URL}/fetch?start=${start}&stop=${stop}&selector=K8S_BENCH%7Bargs~.*tag%3A${tag}%2Ccmd%3D.%2F${cmd}%7D&format=fulltext&dedup=false" > /tmp/tmp1$$
    echo Average ${cmd} ${tag} = $(cat /tmp/tmp1$$ | awk '{ total += $3 } END { print total/NR/1000 }') ms >> /tmp/tmp2$$
  done
done

cat /tmp/tmp2$$

rm /tmp/tmp1$$
rm /tmp/tmp2$$

