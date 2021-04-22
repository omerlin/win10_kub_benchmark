#!/bin/bash
set -e
bash checkEnv.sh
for vol in $(seq 800 999) ; do
  for tag in A B C ; do
    bash measure.sh fetchGTS.sh 1000000000 ${vol} ${tag} --silent
  done
done 

