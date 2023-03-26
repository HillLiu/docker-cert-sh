#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ENV=`${DIR}/env.sh`

if [ -z "$DEPLOY_CMDS" ]; then
  DEPLOY_CMDS=$(awk -F "=" '/^DEPLOY_CMDS\[\]/ {print "\x22"$2"\x22"}' $ENV)
fi

echo $DEPLOY_CMDS
