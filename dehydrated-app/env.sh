#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"

if [ -z "$ENV" ]; then
  if [ -e "${DIR}/.env.dehydrated" ]; then
    ENV="${DIR}/.env.dehydrated"
  else
    ENV="${DIR}/.env.dehydrated.sample"
  fi
fi

echo $ENV
