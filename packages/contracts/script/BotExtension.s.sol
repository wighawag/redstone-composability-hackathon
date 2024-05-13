// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IBaseWorld} from "@latticexyz/world-modules/src/interfaces/IBaseWorld.sol";

import {WorldRegistrationSystem} from "@latticexyz/world/src/modules/init/implementations/WorldRegistrationSystem.sol";

// Create resource identifiers (for the namespace and system)
import {ResourceId} from "@latticexyz/store/src/ResourceId.sol";
import {WorldResourceIdLib} from "@latticexyz/world/src/WorldResourceId.sol";
import {RESOURCE_SYSTEM} from "@latticexyz/world/src/worldResourceTypes.sol";

// For registering the table
import {BotMatch, Vote} from "../src/codegen/index.sol";
import {IStore} from "@latticexyz/store/src/IStore.sol";
import {StoreSwitch} from "@latticexyz/store/src/StoreSwitch.sol";

// For deploying BotActionSystem
import {BotActionSystem} from "../src/systems/BotActionSystem.sol";


function stringToBytes32(string memory source) 
        pure
        returns (bytes32 result) 
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }

contract BotExtensionDeploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address worldAddress = vm.envAddress("WORLD_ADDRESS");
        bytes14 namespace = bytes14(stringToBytes32(vm.envString("NAMESPACE")));

        WorldRegistrationSystem world = WorldRegistrationSystem(worldAddress);
        ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(namespace);
        ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, namespace, "BotActionSystem");

        vm.startBroadcast(deployerPrivateKey);
        world.registerNamespace(namespaceResource);

        StoreSwitch.setStoreAddress(worldAddress);
        // BotMatch.register();
        // Vote.register();

        BotActionSystem botActionSystem = new BotActionSystem();
        console.log("BotActionSystem address: ", address(botActionSystem));

        world.registerSystem(systemResource, botActionSystem, true);
        world.registerFunctionSelector(systemResource, "joinMatch(bytes32,uint256,bytes32)");
        world.registerFunctionSelector(systemResource, "init(bytes32, bytes32)");
        world.registerFunctionSelector(systemResource, "process(bytes32)");
        world.registerFunctionSelector(systemResource, "vote(bytes32,uint8)");
        world.registerFunctionSelector(systemResource, "forceVoteNow(bytes32,uint8)");

        world.registerFunctionSelector(systemResource, "getFactories(bytes32)");
        world.registerFunctionSelector(systemResource, "numFactories(bytes32)");
        world.registerFunctionSelector(systemResource, "getTemplateIds(bytes32,bytes32)");
        world.registerFunctionSelector(systemResource, "getFactoryPosition(bytes32,bytes32)");
        world.registerFunctionSelector(systemResource, "build(bytes32,bytes32,bytes32,int32,int32)");
        world.registerFunctionSelector(systemResource, "getGold(bytes32)");
        


        vm.stopBroadcast();
    }
}
