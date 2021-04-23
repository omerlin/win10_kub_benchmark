vars="silent tag"
silent=false

for arg in $* ; do
  argName=$(echo ${arg} | sed 's/--//g' | cut -f1 -d=)
  argValue=$(echo $arg | sed 's/--//g' | cut -f2 -d=)
  echo ${vars} | grep ${argName} >/dev/null && export ${argName}=${argValue}
done

if [ -z ${tag} ] ; then
  echo missing tag A/B/C
  exit 1
fi
if [ ! -f ./testMod${tag}.mc2 ] ; then
  echo ./testMod${tag}.mc2 not found
  exit 1
fi

if ${silent} ; then
  sed "s/readToken/${READ_TOKEN}/g" ./testMod${tag}.mc2 | curl -i -T - -H 'Transfer-Encoding: chunked' ${WARP_URL}/exec > /dev/null
else
  sed "s/readToken/${READ_TOKEN}/g" ./testMod${tag}.mc2 | curl -i -T - -H 'Transfer-Encoding: chunked' ${WARP_URL}/exec
fi

