#!/bin/env bash
source .env
echo "bot processing in match: $MATCH_ID"
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__process(bytes32)" $MATCH_ID
