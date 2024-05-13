#!/bin/env bash
echo "bot processing in match: $1"
source .env
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__process(bytes32)" $1 
