#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$TOKENS" ]; then
  TOKENS=$(awk -F "=" '/^TOKENS\[\]/ {print "\x22"$2"\x22"}' $ENV)
fi

echo $TOKENS
