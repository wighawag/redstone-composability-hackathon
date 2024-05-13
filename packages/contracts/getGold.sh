#!/bin/env bash
source .env
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__getGold(bytes32)" $MATCH_ID
