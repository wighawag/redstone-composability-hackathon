// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import {PositionData, Position, EntitiesAtPosition, Untraversable, Factory} from '../skystrife/codegen/index.sol';
import {IWorld} from '../skystrife/codegen/world/IWorld.sol';
import { playerFromAddress, matchHasStarted } from "../skystrife/libraries/LibUtils.sol";
import {LibGold} from '../skystrife/libraries/LibGold.sol';

contract BotActionSystem is System {


  function joinMatch(bytes32 matchEntity) external {    
    // join the match
    // for noew take the orb from msg.sender

  }

  // SHould instead use acceptOrbPayment + createMatch
  function acceptOrbPayment() external {

  }
  function withdrawbeforeMatchGetCreated() external {}
  function createMatch() external {

  }



// no way to get list of factories onchain ?
// passing factories list work but allow bot runner to affect which factory get used
// no way to get list of units onchain ?
// passing units list work but allow bot runner to affect which factory get used  
  function process(bytes32 matchEntity, bytes32[] memory factoryEntities, bytes32[] memory unitEntities) external {
    IWorld world = IWorld(_world());
    _processFactories(world, matchEntity, factoryEntities);
    _processUnits(world, matchEntity, unitEntities);
  }


  function _processUnits(IWorld world, bytes32 matchEntity, bytes32[] memory unitEntities) internal {
    // define order ?
    for (uint256 i =0; i < unitEntities.length; i++) {
        _processUnit(world, matchEntity, unitEntities[i]);
    }
  }

  function _processUnit(IWorld world, bytes32 matchEntity, bytes32 unitEntity) internal {
    // TODO find enemy unit or building
    // TODO move or move and fight or fight
  }

  function _processFactories(IWorld world, bytes32 matchEntity, bytes32[] memory factoryEntities) internal {
    // define order ?
    for (uint256 i =0; i < factoryEntities.length; i++) {
        _processFactory(world, matchEntity, factoryEntities[i]);
    }
  }
  
  function _processFactory(IWorld world, bytes32 matchEntity, bytes32 factoryEntity) internal {
    (bool templateFound, bytes32 templateId) = _findTemplateToBuild(matchEntity, factoryEntity);

    if (templateFound) {
        PositionData memory factoryPosition = Position.get(matchEntity, factoryEntity);
        (bool found, PositionData memory positionToBuild) = _findClearPositionAroundFactory(matchEntity, factoryPosition);    

        if (found) {
            world.build(matchEntity, factoryEntity, templateId, positionToBuild);
        }
    }
  }


    function _findTemplateToBuild(bytes32 matchEntity, bytes32 factoryEntity) internal returns (bool found, bytes32 templateId)  {
        bytes32 player = playerFromAddress(matchEntity, address(this));
        int32 gold = LibGold.getCurrent(matchEntity, player);
        bytes32[] memory templateIds = Factory.getPrototypeIds(matchEntity, factoryEntity);
        for (uint256 i = 0; i < templateIds.length; i++) {
            int32 goldCost = Factory.getItemGoldCosts(matchEntity, factoryEntity, i);
            if (goldCost <= gold) {
                found = true;
                templateId = templateIds[i];
            }
        }
    }

  function _findClearPositionAroundFactory(bytes32 matchEntity, PositionData memory factoryPosition) internal view returns (bool found, PositionData memory position) {
    position.x = factoryPosition.x -1;
    position.y = factoryPosition.y;
    if (_isClearPosition(matchEntity, position)) {
        return (true, position);
    }
    position.x = factoryPosition.x;
    position.y = factoryPosition.y - 1;
    if (_isClearPosition(matchEntity, position)) {
        return (true, position);
    }
    position.x = factoryPosition.x + 1;
    position.y = factoryPosition.y;
    if (_isClearPosition(matchEntity, position)) {
        return (true, position);
    }
    position.x = factoryPosition.x;
    position.y = factoryPosition.y + 1;
    if (_isClearPosition(matchEntity, position)) {
        return (true, position);
    }
    return (false, position);
  }

  function _isClearPosition(bytes32 matchEntity, PositionData memory position) internal view returns (bool clear) {
     bytes32[] memory entitiesAtPosition = EntitiesAtPosition.get(matchEntity, position.x, position.y);
    return _isClearOfUntraversableEntities(matchEntity, entitiesAtPosition);
  }

  function _isClearOfUntraversableEntities(bytes32 matchEntity, bytes32[] memory entitiesAtPosition) internal view returns (bool clear) {
    clear = true;
    for (uint256 i = 0; i < entitiesAtPosition.length; i++) {
      if (Untraversable.get(matchEntity, entitiesAtPosition[i])) {
        clear = false;
        break;
      }
    }
  }

}
