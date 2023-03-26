#!/bin/bash
DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"
DOMAINS=$(${DIR}/get-auth-domains.sh)
ZONES=$(${DIR}/get-zones.sh)
TOKENS=$(${DIR}/get-tokens.sh)

INPUT=$1
IFS=' ' read -ra DOMAIN_ARR <<< "$DOMAINS"
IFS=' ' read -ra ZONE_ARR <<< "$ZONES"
IFS=' ' read -ra TOKEN_ARR <<< "$TOKENS"

for i in "${!DOMAIN_ARR[@]}"; do
  if [ "x$INPUT" == "x${DOMAIN_ARR[$i]}" ]; then
    zone_id=$(echo ${ZONE_ARR[$i]} | sed 's/\"//g')
    api_token=$(echo ${TOKEN_ARR[$i]} | sed 's/\"//g')
    break;
  fi
done

#echo $zone_id;
#echo $api_token;

