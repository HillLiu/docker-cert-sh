#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$CERT_DOMAINS" ]; then
  CERT_DOMAINS=$(awk -F "=" '/^CERT_DOMAINS\[\]/ {print "\x22"$2"\x22"}' $ENV)
fi

echo $CERT_DOMAINS
