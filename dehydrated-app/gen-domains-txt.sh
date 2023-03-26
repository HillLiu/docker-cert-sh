#!/bin/bash
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

CERT_DOMAINS=$(${DIR}/get-cert-domains.sh)

echo '##'
echo '# Generate '$DIR'/domains.txt'
echo '##'

echo -n '' > $DIR/domains.txt
eval 'for word in '$CERT_DOMAINS'; do echo $word >> $DIR/domains.txt; done'

echo '' 
cat $DIR/domains.txt
echo '' 

echo '##'
echo '# Generate '$DIR'/domains.txt Success!!'
echo '##'
echo ''
