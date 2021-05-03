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


# Utiliser une des valeurs WSL|KAST|K3S
export BENCH_ENV=KAST

if [ "${BENCH_ENV}" == KAST ] ; then
  # D�finir les WarpTokens ici
  export READ_TOKEN=Eq41VGbc3PmO37soNq8FZWY0Llg4nBf7Mws_2Zkzm0hIvVeYxhZbC9eChg31cGMVaopAfp4hb1AKdPgmL3WP7PRPq6t3nwAqkJcI_2UUqx4UCEJRlPPLb2VS24Ssr9_BDjnpsHZyuC3VPjiLvj6_1ZKP3aZzOKdhYg__kJkirnjwPybiCVrLtV
  export WRITE_TOKEN=G1vMGKzAjGXNDdCJZsTJxMVsC7K0x4Jx8UrO.TVBrZC3P9_XKpjVJDa78boCmLOWfABgBvueQaBf3Q5elm6vHXM332.ncih8cCIIHaFdNE71712JOpxz2kFhnWAKDFVn
else
  export READ_TOKEN=$(readToken)
  export WRITE_TOKEN=$(writeToken)
fi

for var in $(variables) ; do
  echo "export ${var}=${!var}"
done

echo $PATH | grep "\.:" >/dev/null || (export PATH=.:${PATH} && echo "PATH modified")

chmod u+x *.sh

