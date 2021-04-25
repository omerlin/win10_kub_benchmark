#!/bin/bash


variables() {
  echo "NAMESPACE GTS_DIR FUTURE_DATE SYNC_FILE BENCH_ENV READ_TOKEN WRITE_TOKEN PORT TEST"
}

# External port to reach services thru Ingress
export PORT=8081
# Test name will be a label in Warp10 DB
export TEST=K3S

# The GTS data files to inject
export GTS_DIR=/mnt/c/Users/omerlin/MyApp/data/gts

# Inutile de changer ces valeurs
export NAMESPACE=warpdemo
export FUTURE_DATE="2099-01-01T00%3A00%3A00.000Z"
export SYNC_FILE=syncfile.txt
export WARP_URL="http://127.0.0.1:${PORT}/warp10/api/v0" 


# Utiliser une des valeurs WSL|KAST|K3S
export BENCH_ENV=K3S

# Definir les WarpTokens ici
if [ -z READ_TOKEN ]; then
    echo You must export READ_TOKEN ...
    exit 1
fi
if [ -z WRITE_TOKEN ]; then
    echo You must export WRITE_TOKEN ...
    exit 1
fi

for var in $(variables) ; do
  echo "export ${var}=${!var}"
done

echo $PATH | grep "\.:" >/dev/null || (export PATH=.:${PATH} && echo "PATH modified")

chmod u+x *.sh

