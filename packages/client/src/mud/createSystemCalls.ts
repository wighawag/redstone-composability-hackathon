/*
 * Create the system calls that the client can use to ask
 * for changes in the World state (using the System contracts).
 */

import { Hex } from "viem";
import { SetupNetworkResult } from "./setupNetwork";
import { encodeSystemCallFrom } from "@latticexyz/world/internal";
import IWorldAbi from "contracts/out/IWorld.sol/IWorld.abi.json";
import { resourceToHex } from "@latticexyz/common";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

const BOT_SYSTEM_ID = resourceToHex({ type: "system", namespace: "", name: "BotActionSystem" });

export function createSystemCalls(
  /*
   * The parameter list informs TypeScript that:
   *
   * - The first parameter is expected to be a
   *   SetupNetworkResult, as defined in setupNetwork.ts
   *
   *   Out of this parameter, we only care about two fields:
   *   - worldContract (which comes from getContract, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L63-L69).
   *
   *   - waitForTransaction (which comes from syncToRecs, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   *
   * - From the second parameter, which is a ClientComponent,
   *   we only care about Counter. This parameter comes to use
   *   through createClientComponents.ts, but it originates in
   *   syncToRecs
   *   (https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   */
  { worldContract, waitForTransaction }: SetupNetworkResult,
) {
  const joinMatch = async (matchID: Hex) => {
    const freeHero = '0x48616c6265726469657200000000000000000000000000000000000000000000';
    const availableSpawn = 307n
    const tx = await worldContract.write.voteforbot__joinMatch([matchID, availableSpawn, freeHero]);
    await waitForTransaction(tx);
  }

  return {
    joinMatch,
  };
}
