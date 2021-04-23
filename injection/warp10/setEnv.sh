#!/bin/bash

readToken() {
  pod=$(kubectl -n $NAMESPACE get pod -o custom-columns=:metadata.name)
  tokens=$(kubectl -n $NAMESPACE exec -ti $pod -- cat /data/warp10/etc/initial.tokens)
  readToken=$(echo $tokens | sed -e 's/.*{"read":{"token":"//g' -e 's/".*//g')
  echo $readToken
}

writeToken() {
  pod=$(kubectl -n $NAMESPACE get pod -o custom-columns=:metadata.name)
  tokens=$(kubectl -n $NAMESPACE exec -ti $pod -- cat /data/warp10/etc/initial.tokens)
  writeToken=$(echo $tokens | sed -e 's/.*"write":{"token":"//g' -e 's/".*//g')
  echo $writeToken
}

variables() {
  echo "NAMESPACE GTS_DIR FUTURE_DATE SYNC_FILE BENCH_ENV READ_TOKEN WRITE_TOKEN"
}

# Inutile de changer ces valeurs
export NAMESPACE=warpdemo
export GTS_DIR=gts
export FUTURE_DATE="2099-01-01T00%3A00%3A00.000Z"
export SYNC_FILE=syncfile.txt
export WARP_URL="http://127.0.0.1:31080/warp10/api/v0" 
export TEST_NAME=TOBEDEFINED

# Utiliser une des valeurs WSL|KAST|K3S
export BENCH_ENV=KAST

if [ "${BENCH_ENV}" == KAST ] ; then
  # D�finir les WarpTokens ici
  export READ_TOKEN=
  export WRITE_TOKEN=
else
  export READ_TOKEN=$(readToken)
  export WRITE_TOKEN=$(writeToken)
fi

for var in $(variables) ; do
  echo "export ${var}=${!var}"
done

echo $PATH | grep "\.:" >/dev/null || (export PATH=.:${PATH} && echo "PATH modified")

chmod u+x *.sh

