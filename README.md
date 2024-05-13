# Installation and Setup

1. First, clone the repository at https://github.com/Gaonuk/skystrife-public

2. Navigate into the cloned repository and install dependencies using PNPM:

```
pnpm i
```
3. Start the development server:
   
```
pnpm dev
```

This will provide you with a world address.

4. Move back to this repository ([redstone-composability-hackathon](https://github.com/wighawag/redstone-composability-hackathon/)) and navigate to the contracts folder.

5. Ensure you have a .env file in the root directory of this repository with the following content:

```
WORLD_ADDRESS=0xf18058eaf60e826f0afdf2859a80716b587d5359
```
6. Source the .env file:

```
source .env
```
# Interaction with the System
1. At this repository ([redstone-composability-hackathon](https://github.com/wighawag/redstone-composability-hackathon/)) and deploy the bot extension script:

```
forge script BotExtensionDeploy --rpc-url http://localhost:8545 --broadcast
```
```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "botaction3__joinMatch(bytes32,uint256,bytes32)" <matchID> <spawnLocation> <heroTypeID>
```
# Run the Bot
1. Go to http://localhost:1337, and click open & spectate on the default match

2. MatchId is shown on the URL when you spectate a game, copy it: example with matchId = 0x73ecf0f900000000000000000000000000000000000000000000000000000000

3. Replace "0x73ecf0f900000000000000000000000000000000000000000000000000000000" below with the matchID from the step 2 and run it to move the bot
*you can only move the bot once each turn
```
cast send $WORLD_ADDRESS --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY "voteforbot__joinMatch(bytes32,uint256,bytes32)" 0x73ecf0f900000000000000000000000000000000000000000000000000000000 307 0x48616c6265726469657200000000000000000000000000000000000000000000
```
