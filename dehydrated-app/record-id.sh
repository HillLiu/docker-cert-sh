#!/bin/bash

DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"
ZONE_NAME=${ZONE_NAME}
ZONE_ID=${ZONE_ID}
TOKEN=${TOKEN}
DEBUG=`${DIR}/debug.sh`

FORCE_DEBUG=$1

if [ "--debug" == "$FORCE_DEBUG" ]; then
  DEBUG=on
fi

getField() {
  text=$1
  field=$2
  echo $text | sed -n 's|.*"'${field}'"\s*:\s*"\([^"]*\)".*|\1|p'
}

RECORD_ID=$(DEBUG=${DEBUG} ${DIR}/cloudflare-curl.sh -z ${ZONE_ID} -t ${TOKEN} -p dns_records?name=$ZONE_NAME)

if [ -z $DEBUG ]; then
  echo $(getField $RECORD_ID id)
else
  echo $RECORD_ID
fi
