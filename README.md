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


# Interaction with the System

1. Move back to this repository ([redstone-composability-hackathon](https://github.com/wighawag/redstone-composability-hackathon/)) and navigate to the contracts folder.

2. Ensure you have a .env file in the root directory of this repository with the following content:

```
WORLD_ADDRESS=0xf18058eaf60e826f0afdf2859a80716b587d5359
```
3. Source the .env file:

```
source .env
```

4. At this repository ([redstone-composability-hackathon](https://github.com/wighawag/redstone-composability-hackathon/)) and deploy the bot extension script:

```
forge script BotExtensionDeploy --rpc-url http://localhost:8545 --broadcast
```


# create a match

1. Go to http://localhost:1337, and click open & spectate on the default match

2. MatchId is shown on the URL when you spectate a game, copy it: example with matchId = 0x73ecf0f900000000000000000000000000000000000000000000000000000000

# Add the bot

add the matchId to the .env file,

and execute

```bash
./join.sh
```

# Run the Bot

call process as many time as you want

```bash
./process.sh
```

# vote via cli

to vote for the next 30 seconds slot:
```bash
./vote.sh 1 # vote for player 1
./vote.sh 1 # vote for player 1
./vote.sh 2 # vote for player 2
```


to vote instant (debug mode)
```bash
./forceVote.sh 2 # vote for player 2
./forceVote.sh 3 # vote for player 3
./forceVote.sh 3 # vote for player 3
```
