#!/bin/bash

randomTag() {
  # cat /dev/urandom | tr -dc 'A-C' | fold -w ${1:-1} | head -n 1
  printf "\x$(printf %x $((65+$(($RANDOM % 3)))))"
}

set -e
bash checkEnv.sh

bash measure.sh testMacro.sh --tag=$(randomTag) 