import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: 'voteforbot',
  tables: {
    Vote: {
      key: ["matchEntity", "round"],
      schema: {
        matchEntity: "bytes32",
        round: "uint8",
        player1Votes: "uint8",
        player2Votes: "uint8",
        player3Votes: "uint8",
      },
    },
    BotMatch: {
      key: ["matchEntity"],
      schema: {
        matchEntity: "bytes32",
        units: "bytes32[]",
        factories: "bytes32[]",
      },
    },
    Counter: {
      schema: {
        value: "uint32",
      },
      key: [],
    },
  },
});
