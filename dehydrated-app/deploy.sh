#!/bin/bash
DIR="$( cd "$(dirname "$0")" ; pwd -P )"
echo "DOMAIN:" $DOMAIN 
echo "KEYFILE:" $KEYFILE 
echo "CERTFILE:" $CERTFILE
echo "FULLCHAINFILE:" $FULLCHAINFILE
echo "CHAINFILE:" $CHAINFILE
echo "TIMESTAMP:" $TIMESTAMP

DEPLOYS=$(${DIR}/get-deploy-cmds.sh)
eval 'for cmd in '$DEPLOYS'; do echo $cmd | bash; done'

exit 0;
