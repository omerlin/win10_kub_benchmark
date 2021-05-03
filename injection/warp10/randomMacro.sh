#!/bin/bash

randomTag() {
  # cat /dev/urandom | tr -dc 'A-C' | fold -w ${1:-1} | head -n 1
  printf "\x$(printf %x $((65+$(($RANDOM % 3)))))"
}

set -e
bash ./checkEnv.sh

while [ ! -f ${SYNC_FILE} ] ; do
  bash ./measure.sh ./testMacro.sh --tag=$(randomTag)
done

echo "${SYNC_FILE} detected, stopping $0"
 