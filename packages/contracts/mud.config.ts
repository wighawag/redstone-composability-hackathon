import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: 'voteforbot',
  tables: {
    Counter: {
      schema: {
        value: "uint32",
      },
      key: [],
    },
  },
});
