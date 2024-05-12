// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import {BotMatch, BotMatchData, Vote0Data, Vote0, Vote1Data, Vote1} from '../codegen/index.sol';
import {PositionData, Position, EntitiesAtPosition, Untraversable, Factory} from '../skystrife/codegen/index.sol';
import {IWorld} from '../skystrife/codegen/world/IWorld.sol';
import { playerFromAddress, matchHasStarted } from "../skystrife/libraries/LibUtils.sol";
import {LibGold} from '../skystrife/libraries/LibGold.sol';

contract BotActionSystem is System {

 struct VoteData {
    uint8 player1Votes;
    uint8 player2Votes;
    uint8 player3Votes;
 }

  function joinMatch(bytes32 matchEntity) external {    
    // join the match
    // for noew take the orb from msg.sender

    // TODO setup first factory ?
  }

  // SHould instead use acceptOrbPayment + createMatch
  function acceptOrbPayment() external {

  }
  function withdrawbeforeMatchGetCreated() external {}
  function createMatch() external {

  }


    // no way to get list of enemy units onchain ?
    // passing units list work but allow bot runner to affect which factory get used  
  function process(bytes32 matchEntity) external {
    IWorld world = IWorld(_world());
    BotMatchData memory matchInfo = BotMatch.get(matchEntity);

    (bool foundTarget, bytes32 targetPlayer) = _getCurrentTarget(matchEntity);

    _processFactories(world, matchEntity, matchInfo.factories);
    if (foundTarget) {
        _processUnits(world, matchEntity, matchInfo.units, targetPlayer);
    }
    
  }


    function _getCurrentTarget(bytes32 matchEntity) internal view returns (bool found, bytes32 playerTarget) {
        
        VoteData memory voteData = _getCurrentVote(matchEntity);
        if (voteData.player1Votes > voteData.player2Votes && voteData.player1Votes > voteData.player3Votes) {
            found = true;
            playerTarget = 0x0000000000000000000000000000000000000000000000000000000000000001; // TODO
        } else if (voteData.player2Votes > voteData.player1Votes && voteData.player2Votes > voteData.player3Votes) {
            found = true;
            playerTarget = 0x0000000000000000000000000000000000000000000000000000000000000002; // TODO
        } else if (voteData.player3Votes > voteData.player1Votes && voteData.player3Votes > voteData.player2Votes) {
            found = true;
            playerTarget = 0x0000000000000000000000000000000000000000000000000000000000000003; // TODO
        }
    }

  function _getCurrentVote(bytes32 matchEntity) internal view returns (VoteData memory voteData) {
    uint256 round = (block.timestamp / 60) % 2;
    if (round == 0) {
        Vote0Data memory v = Vote0.get(matchEntity);
        voteData.player1Votes = v.voteForPlayer1;
        voteData.player2Votes = v.voteForPlayer2;
        voteData.player3Votes = v.voteForPlayer3;
    } else {
        Vote1Data memory v = Vote1.get(matchEntity);
        voteData.player1Votes = v.voteForPlayer1;
        voteData.player2Votes = v.voteForPlayer2;
        voteData.player3Votes = v.voteForPlayer3;
    }
  }


  function _processUnits(IWorld world, bytes32 matchEntity, bytes32[] memory unitEntities, bytes32 targetPlayer) internal {
    // define order ?
    for (uint256 i =0; i < unitEntities.length; i++) {
        _processUnit(world, matchEntity, unitEntities[i]);
    }
  }

  function _processUnit(IWorld world, bytes32 matchEntity, bytes32 unitEntity) internal {
    // check if not dead
    // TODO swap with last and remove last

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
            bytes32 newUnits = world.build(matchEntity, factoryEntity, templateId, positionToBuild);
            BotMatch.pushUnits(matchEntity, newUnits);
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
