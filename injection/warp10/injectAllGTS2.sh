#!/bin/bash
set -e
bash ./checkEnv.sh
export SCRIPT_HOME=/mnt/c/Users/omerlin/MyApp/bench/win10_kub_benchmark/injection/warp10
#export PATH=$SCRIPT_HOME:$PATH
cd ${GTS_DIR}
for gts in `find . -name "*.gts" -print`; do
    ${SCRIPT_HOME}/measure.sh ${SCRIPT_HOME}/injectGTS2.sh ${gts}
done

