#!/bin/env bash
source .env
echo "joining match: $MATCH_ID ($NAMESPACE)"
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "${NAMESPACE}__joinMatch(bytes32,uint256,bytes32)" "$MATCH_ID" "${1:-"0"}" "0x48616c6265726469657200000000000000000000000000000000000000000000"
