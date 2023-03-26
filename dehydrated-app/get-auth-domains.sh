#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$AUTH_DOMAINS" ]; then
  AUTH_DOMAINS=$(awk -F "=" '/^AUTH_DOMAINS\[\]/ {print $2}' $ENV)
fi

echo $AUTH_DOMAINS
