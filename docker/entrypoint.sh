#!/usr/bin/env sh

LETSENCRYPT_TEST=$(/app/is-letsencrypt-test.sh)
CA_HOST=${CA_HOST}

# docker entrypoint script
usage() {
  echo -n "
  $0 --get-ca
  -h | --help dump help docs.
  --gen For get .env.dehydrated sample or template.
"
}

run() {
  if [ ! -z "$LETSENCRYPT_TEST" ]; then
    CA_HOST=letsencrypt-test
  fi
  if [ ! -z "$CA_HOST" ]; then
    CA_HOST='--ca '$CA_HOST
  fi

  /app/gen-domains-txt.sh

  /app/dehydrated --register --accept-terms $CA_HOST

  cmd='/app/dehydrated -c -t dns-01 -k /app/hook.sh '$CA_HOST
  echo ""
  echo $cmd
  echo ""
  echo $cmd | bash
}

gen() {
  cat /app/.env.dehydrated.sample
}

server() {
  tail -f /entrypoint.sh
}

if [ "$1" = 'server' ]; then
  server
else
  if [ ! -f "/app/.env.dehydrated" ]; then
    echo "You need generate .env.dehydrated first check the --gen"
    usage
    exit
  fi

  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      -h | --help)
        usage
        exit
        ;;
      --get-ca)
        run
        exit
        ;;
      --gen)
        gen
        exit
        ;;
    esac
    shift # past argument or value
  done

  usage
  exec "$@"
fi
