#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$LETSENCRYPT_TEST" ]; then
  LETSENCRYPT_TEST=$(awk -F "=" '/^LETSENCRYPT_TEST/ {print $2}' $ENV)
fi

if [ ! -z "$LETSENCRYPT_TEST" ]; then
  if [ "x$LETSENCRYPT_TEST" != "xoff" ]; then
    echo 1
  fi
fi
