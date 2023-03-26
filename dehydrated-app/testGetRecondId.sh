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

stripQuote() {
  text=$1
  echo $text | sed 's/\"//g'
}

printf "%s\t%-20s\t%-32s\t%-32s\n" "SN" "DOMAIN" "ZONE" "TOKEN"
for i in "${!DOMAIN_ARR[@]}"; do
  DOMAIN=${DOMAIN_ARR[$i]}
  ZONE=$(stripQuote ${ZONE_ARR[$i]})
  TOKEN=$(stripQuote ${TOKEN_ARR[$i]})
  RECORD_ID=$(ZONE_ID=${ZONE} ZONE_NAME=${DOMAIN} TOKEN=${TOKEN} ${DIR}/record-id.sh)
  printf "%s\t%-20s\t%s\t%s\t%s\n" "$i" "$DOMAIN" "$ZONE" "$TOKEN"
  echo Result: $RECORD_ID
done

