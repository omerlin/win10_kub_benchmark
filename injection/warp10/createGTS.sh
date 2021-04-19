#!/bin/bash
pythonBin=python.exe
pythonScript=./createGTSmod1.py
gtsDir=$(cd $(dirname $0) && pwd)/gts
mkdir -p $gtsDir
missions=$(seq 700 799)
vols=$(seq 1 8)
for mission in $missions; do
  for vol in $vols; do
    $pythonBin $pythonScript $mission $vol A 1 2000 600000 5 > $gtsDir/m${mission}v${vol}A.gts
    $pythonBin $pythonScript $mission $vol B 1 2200 600000 5 > $gtsDir/m${mission}v${vol}B.gts
    $pythonBin $pythonScript $mission $vol C 1 20000 600000 5 > $gtsDir/m${mission}v${vol}C.gts
    echo "mission $mission vol $vol"
  done
done

