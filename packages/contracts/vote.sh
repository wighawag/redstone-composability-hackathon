#!/bin/env bash
source .env
echo "voting for $1 in match $MATCH_ID"
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__vote(bytes32,uint8)" $MATCH_ID $1
