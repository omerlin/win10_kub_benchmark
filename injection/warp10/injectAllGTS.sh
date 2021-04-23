#!/bin/bash
set -e
bash ./checkEnv.sh
gtsDir=$(cd $(dirname $0) && pwd)/${GTS_DIR}
for gts in gts/*.gts; do
    bash ./measure.sh ./injectGTS.sh $(echo $(basename ${gts}) | sed "s/\..*//g") 
done

