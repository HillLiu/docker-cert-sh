#!/bin/bash
DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"
AUTH_EMAIL=$(${DIR}/auth-email.sh)
AUTH_KEY=$(${DIR}/auth-key.sh)
DEBUG=$(${DIR}/debug.sh)

usage() {
  echo -n "
  cloudflare-curl.sh -m [METHOD] -p [PATH] -z [ZONE_ID] -t [API_TOKEN] your-data 
"
}

data=''

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h | --help)
      usage
      exit
      ;;
    -m | --method)
      CURL_METHOD=$2
      shift
      ;;
    -p | --path)
      CURL_PATH=$2
      shift
      ;;
    -z | --id)
      ZONE_ID=$2
      shift
      ;;
    -t | --token)
      API_TOKEN=$2
      shift
      ;;
    --debug)
      DEBUG=on
      ;;
    *)
      data+=$key
      data+=' '
      ;;
  esac
  shift # past argument or value
done

data=$(echo -e "${data}" | sed -e 's/^[[:space:]]//' -e 's/[[:space:]]$//')

if [ "x" == "x$ZONE_ID" ]; then
  echo "Should set ZONE_ID."
  exit 1;
fi

if [ "x" == "x$CURL_PATH" ]; then
  echo "Should set CURL_PATH."
  exit 2;
fi

cmd="curl -s -X ${CURL_METHOD-GET}"
cmd+=" 'https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/${CURL_PATH}'"
cmd+=" -H 'Content-Type:application/json'"

# Auth
if [ -z $API_TOKEN ]; then
  if [ "x" == "x$AUTH_KEY" ] || [ "x" == "x$AUTH_EMAIL" ]; then
    echo "Shoud have AUTH_KEY, AUTH_EMAIL or API_TOKEN."
    exit 3; 
  fi
  cmd+=" -H 'X-Auth-Key: ${AUTH_KEY}'"
  cmd+=" -H 'X-Auth-Email: ${AUTH_EMAIL}'"
else
  cmd+=" -H 'Authorization: Bearer ${API_TOKEN}'"
fi

if [ ! -z "$data" ]; then
  cmd+=" --data '${data}';"
fi

if [ ! -z "$DEBUG" ]; then
  echo $cmd
else
  result=$(echo "$cmd" | bash)
  if [[ $result =~ "\"success\":false" ]]; then
    echo >&2 "$result --- $cmd"
  else
    echo "$result"
  fi
fi
