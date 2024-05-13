first clone : https://github.com/Gaonuk/skystrife-public

in that clone do

```
pnpm i
pnpm dev
```

this will give you a world address

then move back into this repo ([redstone-composability-hackathon](https://github.com/wighawag/redstone-composability-hackathon/))_, navgate to contracts folder


ensure you have a .env file with `WORLD_ADDRESS=0xf18058eaf60e826f0afdf2859a80716b587d5359`

then:


```
source .env
```

```
forge script BotExtensionDeploy --rpc-url http://localhost:8545 --broadcast
```

```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "botaction3__joinMatch(bytes32,uint256,bytes32)" <matchID> <spawnLocation> <heroTypeID>
```

matchId is shown when you spectate a game

got to http://localhost:1337 and click spectate on the default match

then we will use the default spawn position: 307 and the default hero type: 0x48616c6265726469657200000000000000000000000000000000000000000000

example with matchId = 0x73ecf0f900000000000000000000000000000000000000000000000000000000

replace it with your matchID

```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__joinMatch(bytes32,uint256,bytes32)" 0x73ecf0f900000000000000000000000000000000000000000000000000000000 307 0x48616c6265726469657200000000000000000000000000000000000000000000
```


make it move

```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__process(bytes32)" 0x73ecf0f900000000000000000000000000000000000000000000000000000000
```