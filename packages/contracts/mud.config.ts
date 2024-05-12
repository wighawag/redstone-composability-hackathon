import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: 'voteforbot',
  tables: {
    Vote0: {
      key: ["matchEntity"],
      schema: {
        matchEntity: "bytes32",
        voteForPlayer1: "uint8",
        voteForPlayer2: "uint8",
        voteForPlayer3: "uint8",
      },
    },
    Vote1: {
      key: ["matchEntity"],
      schema: {
        matchEntity: "bytes32",
        voteForPlayer1: "uint8",
        voteForPlayer2: "uint8",
        voteForPlayer3: "uint8",
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
