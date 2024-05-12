import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: 'voteforbot',
  tables: {
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
