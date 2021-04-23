#!/bin/bash

randomTag() {
  # cat /dev/urandom | tr -dc 'A-C' | fold -w ${1:-1} | head -n 1
  printf "\x$(printf %x $((65+$(($RANDOM % 3)))))\n"
}

randomVol() {
  echo $((800+$(($RANDOM % 200))))
}

randomMission() {
  echo $((1+$(($RANDOM % 8))))
}


set -e
bash checkEnv.sh

bash measure.sh fetchGTS.sh --vol=$(randomVol)_$(randomMission) --tag=$(randomTag) 