#!/bin/env bash
source .env
echo "bot processing in match: $MATCH_ID"
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__build(bytes32,bytes32,bytes32,int32,int32)" $MATCH_ID $1 $2 $3 $4 $5
