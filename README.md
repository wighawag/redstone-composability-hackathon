

```
source .env
```

```
forge script BotExtensionDeploy --rpc-url http://localhost:8545 --broadcast
```

```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "botaction3__joinMatch(bytes32,uint256,bytes32)" <matchID> <spawnLocation> <heroTypeID>
```

matchId is shown when ou spectate a game

example

```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "botaction3__joinMatch(bytes32,uint256,bytes32)" 0x58fd5c7b00000000000000000000000000000000000000000000000000000000 307 0x48616c6265726469657200000000000000000000000000000000000000000000
```