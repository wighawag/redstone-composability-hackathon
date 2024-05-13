#!/bin/env bash
echo "voting for $2 in match $1"
source .env
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__vote(bytes32,uint8)" $1 $2
