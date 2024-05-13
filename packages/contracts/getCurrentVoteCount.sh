#!/bin/env bash
source .env
cast call $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__getCurrentVote(bytes32,uint8)" $MATCH_ID $1
