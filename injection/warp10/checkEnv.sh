#!/bin/bash

variables() {
  echo "NAMESPACE GTS_DIR FUTURE_DATE SYNC_FILE BENCH_ENV READ_TOKEN WRITE_TOKEN"
}

for var in $(variables) ; do
  if [ "${!var}" == "" ] ; then
    echo "Error : ${var} is undefined"
    undef=${var}
  fi
done

if [ ! -z ${undef} ] ; then
  exit 1
fi
