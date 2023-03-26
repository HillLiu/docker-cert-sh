#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$ZONES" ]; then
  ZONES=$(awk -F "=" '/^ZONES\[\]/ {print "\x22"$2"\x22"}' $ENV)
fi

echo $ZONES
