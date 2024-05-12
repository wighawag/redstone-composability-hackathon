// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import {BotMatch, BotMatchData, VoteData, Vote} from '../codegen/index.sol';
import {PositionData, Position, EntitiesAtPosition, Untraversable, Factory, MatchPlayers, MatchFinished} from '../skystrife/codegen/index.sol';
import {IWorld} from '../skystrife/codegen/world/IWorld.sol';
import { playerFromAddress, matchHasStarted, isOwnedByAddress, isOwnedBy } from "../skystrife/libraries/LibUtils.sol";
import {LibGold} from '../skystrife/libraries/LibGold.sol';

contract BotActionSystem is System {

  error BotNotInMatch();
  error MatchAlreadyFinished();


  function joinMatch(bytes32 matchEntity) external {    
    // join the match
    // for noew take the orb from msg.sender

    // TODO setup first factory ?
  }

  

  // // SHould instead use acceptOrbPayment + createMatch
  // function acceptOrbPayment() external {

  // }
  // function withdrawbeforeMatchGetCreated() external {}
  // function createMatch() external {

  // }



  // to be called once so that the bot knows its first factory
  function init(bytes32 matchEntity, bytes32 factoryEntity) external {
    if (MatchFinished.get(matchEntity)) {
      revert MatchAlreadyFinished();
    }
    bytes32[] memory factories = BotMatch.getFactories(matchEntity);
    for (uint256 i = 0; i < factories.length; i++) {
      if (factories[i] == factoryEntity) {
        return;
      }
    }
    BotMatch.pushFactories(matchEntity, factoryEntity);
  }

    // no way to get list of enemy units onchain ?
    // passing units list work but allow bot runner to affect which factory get used  
  function process(bytes32 matchEntity) external {
    if (MatchFinished.get(matchEntity)) {
      revert MatchAlreadyFinished();
    }

    IWorld world = IWorld(_world());
    BotMatchData memory matchInfo = BotMatch.get(matchEntity);

    (bool foundTarget, bytes32 targetPlayer) = _getCurrentTarget(matchEntity);

    _processFactories(world, matchEntity, matchInfo.factories);
    if (foundTarget) {
        _processUnits(world, matchEntity, matchInfo.units, targetPlayer);
    }
    
  }
 

    function _getCurrentTarget(bytes32 matchEntity) internal view returns (bool found, bytes32 playerTarget) {
        bytes32 botPlayer = playerFromAddress(matchEntity, address(this));
        bytes32[] memory playersInMatch = MatchPlayers.get(matchEntity); // asume 4 players
        bytes32 player1;
        bytes32 player2;
        bytes32 player3;
        if (playersInMatch[0] == botPlayer) {
          player1 = playersInMatch[1];
          player2 = playersInMatch[2];
          player3 = playersInMatch[3];
        } else if (playersInMatch[1] == botPlayer) {
          player1 = playersInMatch[0];
          player2 = playersInMatch[2];
          player3 = playersInMatch[3];
        } else if (playersInMatch[2] == botPlayer) {
          player1 = playersInMatch[0];
          player2 = playersInMatch[1];
          player3 = playersInMatch[3];
        } else if (playersInMatch[3] == botPlayer) {
          player1 = playersInMatch[0];
          player2 = playersInMatch[1];
          player3 = playersInMatch[2];
        } else {
          revert BotNotInMatch();
        }

        VoteData memory voteData = _getCurrentVote(matchEntity);
        if (voteData.player1Votes > voteData.player2Votes && voteData.player1Votes > voteData.player3Votes) {
            found = true;
            playerTarget = player1;
        } else if (voteData.player2Votes > voteData.player1Votes && voteData.player2Votes > voteData.player3Votes) {
            found = true;
            playerTarget = player2;
        } else if (voteData.player3Votes > voteData.player1Votes && voteData.player3Votes > voteData.player2Votes) {
            found = true;
            playerTarget = player3;
        }
    }

  function _getCurrentVote(bytes32 matchEntity) internal view returns (VoteData memory voteData) {
    uint256 round = (block.timestamp / 60) % 2;
    voteData = Vote.get(matchEntity, uint8(round));
  }


  function _processUnits(IWorld world, bytes32 matchEntity, bytes32[] memory unitEntities, bytes32 targetPlayer) internal {
    // define order ?
    for (uint256 i = 0; i < unitEntities.length; i++) {
      // check if not dead, is that eneough ?
      if (!isOwnedByAddress(matchEntity, unitEntities[i], address(this))) {
        // TODO delete
        // Note that this check is probably sufficient as when a unit is killed it losed its owner: https://github.com/latticexyz/skystrife-public/blob/d89c6ed1423a406f3f897c0fb5db2b2d41e2f027/packages/contracts/src/libraries/LibCombat.sol#L115
      } else {
        _processUnit(world, matchEntity, unitEntities[i], targetPlayer);
      }
    }
  }

  function _processUnit(IWorld world, bytes32 matchEntity, bytes32 unitEntity, bytes32 targetPlayer) internal {
    PositionData memory from = Position.get(matchEntity, unitEntity);
    // TODO find enemy unit or building
    // best would be to provide path data from client and check it, but how to check if best move
    // else player running the process can put units in the wrong path
    // for now move randomly
    
    (bool found, bytes32 targetEntity, ) = _findNeighborTarget(matchEntity, from, targetPlayer);
    if (found) {
       world.fight(matchEntity, unitEntity, targetEntity);
    } else {
      (bool clear, PositionData memory positionToMoveTo) = _findClearPositionAround(matchEntity, from);
      if (clear) {
        PositionData[] memory path = new PositionData[](1);
        path[0] = positionToMoveTo;
        world.move(matchEntity, unitEntity, path);
      }
    }
    
   
  }

  function _findNeighborTarget(bytes32 matchEntity, PositionData memory unitPosition, bytes32 targetPlayer) internal view returns (bool found, bytes32 targetEntity, PositionData memory targetPosition) {
    PositionData[] memory neighborsDelta =  new PositionData[](4);
    neighborsDelta[0] = PositionData({x: -1, y: 0});
    neighborsDelta[1] = PositionData({x: 0, y: -1});
    neighborsDelta[2] = PositionData({x: 1, y: 0});
    neighborsDelta[3] = PositionData({x: 0, y: 1});

    uint256 offset = block.timestamp % 4;
    for (uint256 i = 0; i < neighborsDelta.length; i++){
      uint256 index = (i + offset) % 4;
      targetPosition.x = unitPosition.x + neighborsDelta[index].x;
      targetPosition.y = unitPosition.y + neighborsDelta[index].y;
      (found, targetEntity) = _hasTargetUnit(matchEntity, targetPosition, targetPlayer);
      if (found) {
          return (found, targetEntity, targetPosition);
      } 
    }
  }
  
  function _hasTargetUnit(bytes32 matchEntity, PositionData memory targetPosition, bytes32 targetPlayer) internal view returns (bool found, bytes32 targetEntity) {
     bytes32[] memory entitiesAtPosition = EntitiesAtPosition.get(matchEntity, targetPosition.x, targetPosition.y);
    return _isTargetEntities(matchEntity, entitiesAtPosition, targetPlayer);
  }

  function _isTargetEntities(bytes32 matchEntity, bytes32[] memory entitiesAtPosition, bytes32 targetPlayer) internal view returns (bool isTarget, bytes32 targetEntity) {
    for (uint256 i = 0; i < entitiesAtPosition.length; i++) {
      if (isOwnedBy(matchEntity, entitiesAtPosition[i], targetPlayer)) {
        return (true, entitiesAtPosition[i]);
      }
    }
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
        (bool found, PositionData memory positionToBuild) = _findClearPositionAround(matchEntity, factoryPosition);    

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

  function _findClearPositionAround(bytes32 matchEntity, PositionData memory fromPosition) internal view returns (bool found, PositionData memory position) {
    PositionData[] memory neighborsDelta =  new PositionData[](4);
    neighborsDelta[0] = PositionData({x: -1, y: 0});
    neighborsDelta[1] = PositionData({x: 0, y: -1});
    neighborsDelta[2] = PositionData({x: 1, y: 0});
    neighborsDelta[3] = PositionData({x: 0, y: 1});

    uint256 offset = block.timestamp % 4;
    for (uint256 i = 0; i < neighborsDelta.length; i++){
      uint256 index = (i + offset) % 4;
      position.x = fromPosition.x + neighborsDelta[index].x;
      position.y = fromPosition.y + neighborsDelta[index].y;
      (found) = _isClearPosition(matchEntity, position);
      if (found) {
          return (found, position);
      } 
    }
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
