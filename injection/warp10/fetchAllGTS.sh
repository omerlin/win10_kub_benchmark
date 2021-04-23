#!/bin/bash
set -e
bash checkEnv.sh
for vol in $(seq 800 999) ; do
  for tag in A B C ; do
    bash measure.sh fetchGTS.sh --vol=${vol} --tag=${tag} --silent=true
  done
done 

