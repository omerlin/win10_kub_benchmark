set -e
bash ./checkEnv.sh
startTime=$(date +%s%N)
$@ 
execTime=$((($(date +%s%N) - $startTime)/1000))
now=$(($(date +%s%N)/1000))
cmd=$1
shift
args=$(echo $@ | sed -e 's/--//g' -e 's/=/:/g')
TS="$now// K8S_BENCH{envir=$BENCH_ENV, host=$(hostname), test=$TEST_NAME, cmd=$cmd, args=$args} $execTime"
echo ${TS}
echo ${TS} | curl -H "X-Warp10-Token:${WRITE_TOKEN}" -H 'Transfer-Encoding: chunked' --data-binary @- ${WARP_URL}/update 
