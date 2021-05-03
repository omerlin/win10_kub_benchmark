#!/bin/bash
           
for var in NAMESPACE GTS_DIR FUTURE_DATE SYNC_FILE BENCH_ENV READ_TOKEN WRITE_TOKEN PORT TEST ; do
  if [ "${!var}" == "" ] ; then
    echo "Error : ${var} is undefined"
    undef=${var}
  fi
done

if [ ! -z ${undef} ] ; then
  exit 1
fi
