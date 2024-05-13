#!/bin/env bash
source .env
cast call $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__getTemplateIds(bytes32,bytes32)" $MATCH_ID $1
