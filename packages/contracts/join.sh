#!/bin/env bash
echo "joining match: $1"
source .env
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__joinMatch(bytes32,uint256,bytes32)" "$1" "${2:-"307"}" "0x48616c6265726469657200000000000000000000000000000000000000000000"
