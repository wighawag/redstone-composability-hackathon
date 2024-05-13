// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import {System} from "@latticexyz/world/src/System.sol";
import {BotMatch, BotMatchData, VoteData, Vote} from "../codegen/index.sol";
import {
    PositionData,
    Position,
    EntitiesAtPosition,
    Untraversable,
    Factory,
    MatchPlayers,
    MatchFinished,
    MatchConfig,
    MatchConfigData,
    LevelTemplates,
    HeroInRotation,
    SpawnReservedBy,
    MatchSpawnPoints,
    NameExists,
    Gold
} from "../skystrife/codegen/index.sol";
import {IWorld} from "../skystrife/codegen/world/IWorld.sol";
import { SpawnSettlementTemplateId } from "../skystrife/codegen/Templates.sol";
import {playerFromAddress, matchHasStarted, isOwnedByAddress, isOwnedBy} from "../skystrife/libraries/LibUtils.sol";
import {LibGold} from "../skystrife/libraries/LibGold.sol";
import {findMapCenter} from "../skystrife/libraries/LibMatch.sol";
import {createMatchEntity} from "../skystrife/createMatchEntity.sol";

contract BotActionSystem is System {
    error BotNotInMatch();
    error MatchAlreadyFinished();


    uint256 constant public NUM_SECONDS = 30;

    function joinMatch(bytes32 matchEntity, uint256 spawnIndexToStartFrom, bytes32 heroChoice) external {
        // join the match
        // for noew take the orb from msg.sender
        // MatchConfigData memory matchConfig = MatchConfig.get(matchEntity);
        // bytes32 isReserved = SpawnReservedBy.get(matchEntity, 0);


        (bool foundSpawn, uint256 spawnIndex) = _findSpawn(matchEntity, spawnIndexToStartFrom);

        require(foundSpawn, "no available spawn point found");
        
        
        uint256 numSpawnPointsPrior = MatchSpawnPoints.length(matchEntity);
        IWorld world = IWorld(_world());
        world.register(matchEntity, spawnIndex, heroChoice);
        string memory name = "Joker";
        // bytes32 nameBytes = bytes32(keccak256(bytes(name)));
        // if (NameExists.get(nameBytes) == false) {
          world.setName(name);
        // }
        
        world.toggleReady(matchEntity);

       _setupFactoriesAndUnits(matchEntity, numSpawnPointsPrior);
    }

    function _setupFactoriesAndUnits(bytes32 matchEntity, uint256 numSpawnPointsPrior) internal {
       // We get the spawn point from the last index
        bytes32 spawnPoint = MatchSpawnPoints.getItem(matchEntity, numSpawnPointsPrior);
        PositionData memory spawnPosition = Position.get(matchEntity, spawnPoint);
        
        bytes32[] memory spawnPointEntities = EntitiesAtPosition.get(matchEntity, spawnPosition.x, spawnPosition.y);
        for (uint256 i = 0; i < spawnPointEntities.length; i++) {
          // we then push factories created there
          BotMatch.pushFactories(matchEntity, spawnPointEntities[i]);
        }

        PositionData memory mapCenter = findMapCenter(matchEntity);
        // we compute the location of the heror based on LibMatch.spawnStarter 
        int32 xDiff = spawnPosition.x - mapCenter.x;
        int32 yDiff = spawnPosition.y - mapCenter.y;
        if (spawnPosition.x > 0) {
          spawnPosition.x = spawnPosition.x - 1;
        } else if (xDiff < 0) {
          spawnPosition.x = spawnPosition.x + 1;
        } else if (yDiff > 0) {
          spawnPosition.y = spawnPosition.y - 1;
        } else {
          spawnPosition.y = spawnPosition.y + 1;
        }
        bytes32[] memory entities = EntitiesAtPosition.get(matchEntity, spawnPosition.x, spawnPosition.y);
        for (uint256 i = 0; i < entities.length; i++) {
          // we then push units created there (should be the hero)
          BotMatch.pushUnits(matchEntity, entities[i]);
        }
        
    }

    function _findSpawn(bytes32 matchEntity, uint256 spawnIndexToStartFrom) internal view returns (bool found, uint256 spawnIndex) {
        bytes32 levelId = MatchConfig.getLevelId(matchEntity);
        for (uint256 i = spawnIndexToStartFrom; i < 10000; i++) {
          if (LevelTemplates.getItem(levelId, i) == SpawnSettlementTemplateId && SpawnReservedBy.get(matchEntity, i) == 0) {
            return (true, i);
          }
        }
        // fallback
        return (true, spawnIndexToStartFrom);
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
        _processUnits(world, matchEntity, matchInfo.units, foundTarget, targetPlayer);
    }



     function vote(bytes32 matchEntity, uint8 voteIndex) external {
        if (MatchFinished.get(matchEntity)) {
            revert MatchAlreadyFinished();
        }

        uint8 nextRound = uint8(((block.timestamp / NUM_SECONDS) +1) % 2); // every 30 seconds
        if (voteIndex == 1) {
          Vote.setPlayer1Votes(matchEntity, nextRound, Vote.getPlayer1Votes(matchEntity, nextRound) + 1);
        } else if (voteIndex == 2) {
          Vote.setPlayer2Votes(matchEntity, nextRound, Vote.getPlayer2Votes(matchEntity, nextRound) + 1);
        } else if (voteIndex == 3) {
          Vote.setPlayer3Votes(matchEntity, nextRound, Vote.getPlayer3Votes(matchEntity, nextRound) + 1);
        } else {
          require(false, "invalid vote");
        }
        
    }

    function forceVoteNow(bytes32 matchEntity, uint8 voteIndex) external {
        if (MatchFinished.get(matchEntity)) {
            revert MatchAlreadyFinished();
        }

        uint8 round = uint8(((block.timestamp / NUM_SECONDS)) % 2); // every 30 seconds
        if (voteIndex == 1) {
          Vote.setPlayer1Votes(matchEntity, round, Vote.getPlayer1Votes(matchEntity, round) + 1);
        } else if (voteIndex == 2) {
          Vote.setPlayer2Votes(matchEntity, round, Vote.getPlayer2Votes(matchEntity, round) + 1);
        } else if (voteIndex == 3) {
          Vote.setPlayer3Votes(matchEntity, round, Vote.getPlayer3Votes(matchEntity, round) + 1);
        } else {
          require(false, "invalid vote");
        }
        
    }

    function _getCurrentTarget(bytes32 matchEntity) internal view returns (bool found, bytes32 playerTarget) {
        bytes32 botPlayer = playerFromAddress(matchEntity, address(this));
        bytes32[] memory playersInMatch = MatchPlayers.get(matchEntity); // asume 4 players
        if (playersInMatch.length != 4) {
          return (false, playerTarget);
        }
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
        uint256 round = (block.timestamp / NUM_SECONDS) % 2;
        voteData = Vote.get(matchEntity, uint8(round));
    }

    function _processUnits(IWorld world, bytes32 matchEntity, bytes32[] memory unitEntities, bool hasTarget, bytes32 targetPlayer)
        internal
    {
        // define order ?
        for (uint256 i = 0; i < unitEntities.length; i++) {
            // check if not dead, is that eneough ?
            if (!isOwnedByAddress(matchEntity, unitEntities[i], address(this))) {
                // TODO delete
                // Note that this check is probably sufficient as when a unit is killed it losed its owner: https://github.com/latticexyz/skystrife-public/blob/d89c6ed1423a406f3f897c0fb5db2b2d41e2f027/packages/contracts/src/libraries/LibCombat.sol#L115
            } else {
                _processUnit(world, matchEntity, unitEntities[i], hasTarget, targetPlayer);
            }
        }
    }

    function _processUnit(IWorld world, bytes32 matchEntity, bytes32 unitEntity, bool hasTarget, bytes32 targetPlayer) internal {
        PositionData memory from = Position.get(matchEntity, unitEntity);
        // TODO find enemy unit or building
        // best would be to provide path data from client and check it, but how to check if best move
        // else player running the process can put units in the wrong path
        // for now move randomly

        bool found;
        bytes32 targetEntity;
        if (hasTarget) {
          (found, targetEntity,) = _findNeighborTarget(matchEntity, from, targetPlayer);  
        }
        
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

    function _findNeighborTarget(bytes32 matchEntity, PositionData memory unitPosition, bytes32 targetPlayer)
        internal
        view
        returns (bool found, bytes32 targetEntity, PositionData memory targetPosition)
    {
        PositionData[] memory neighborsDelta = new PositionData[](4);
        neighborsDelta[0] = PositionData({x: -1, y: 0});
        neighborsDelta[1] = PositionData({x: 0, y: -1});
        neighborsDelta[2] = PositionData({x: 1, y: 0});
        neighborsDelta[3] = PositionData({x: 0, y: 1});

        uint256 offset = uint256(block.prevrandao) % 4;
        for (uint256 i = 0; i < neighborsDelta.length; i++) {
            uint256 index = (i + offset) % 4;
            targetPosition.x = unitPosition.x + neighborsDelta[index].x;
            targetPosition.y = unitPosition.y + neighborsDelta[index].y;
            (found, targetEntity) = _hasTargetUnit(matchEntity, targetPosition, targetPlayer);
            if (found) {
                return (found, targetEntity, targetPosition);
            }
        }
    }

    function _hasTargetUnit(bytes32 matchEntity, PositionData memory targetPosition, bytes32 targetPlayer)
        internal
        view
        returns (bool found, bytes32 targetEntity)
    {
        bytes32[] memory entitiesAtPosition = EntitiesAtPosition.get(matchEntity, targetPosition.x, targetPosition.y);
        return _isTargetEntities(matchEntity, entitiesAtPosition, targetPlayer);
    }

    function _isTargetEntities(bytes32 matchEntity, bytes32[] memory entitiesAtPosition, bytes32 targetPlayer)
        internal
        view
        returns (bool isTarget, bytes32 targetEntity)
    {
        for (uint256 i = 0; i < entitiesAtPosition.length; i++) {
            if (isOwnedBy(matchEntity, entitiesAtPosition[i], targetPlayer)) {
                return (true, entitiesAtPosition[i]);
            }
        }
    }

    function _processFactories(IWorld world, bytes32 matchEntity, bytes32[] memory factoryEntities) internal {
        // define order ?
        for (uint256 i = 0; i < factoryEntities.length; i++) {
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

    function _findTemplateToBuild(bytes32 matchEntity, bytes32 factoryEntity)
        internal view
        returns (bool found, bytes32 templateId)
    {
        bytes32 player = playerFromAddress(matchEntity, address(this));
        int32 gold = Gold.get(matchEntity, player); // TODO  LibGold.getCurrent(matchEntity, player);
        bytes32[] memory templateIds = Factory.getPrototypeIds(matchEntity, factoryEntity);
        for (uint256 i = 0; i < templateIds.length; i++) {
            int32 goldCost = Factory.getItemGoldCosts(matchEntity, factoryEntity, i);
            if (goldCost <= gold) {
                return (true,  templateIds[i]);
            }
        }
    }

    function _findClearPositionAround(bytes32 matchEntity, PositionData memory fromPosition)
        internal
        view
        returns (bool found, PositionData memory position)
    {
        PositionData[] memory neighborsDelta = new PositionData[](4);
        neighborsDelta[0] = PositionData({x: -1, y: 0});
        neighborsDelta[1] = PositionData({x: 0, y: -1});
        neighborsDelta[2] = PositionData({x: 1, y: 0});
        neighborsDelta[3] = PositionData({x: 0, y: 1});

        uint256 offset = uint256(block.prevrandao) % 4;
        for (uint256 i = 0; i < neighborsDelta.length; i++) {
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

    function _isClearOfUntraversableEntities(bytes32 matchEntity, bytes32[] memory entitiesAtPosition)
        internal
        view
        returns (bool clear)
    {
        clear = true;
        for (uint256 i = 0; i < entitiesAtPosition.length; i++) {
            if (Untraversable.get(matchEntity, entitiesAtPosition[i])) {
                clear = false;
                break;
            }
        }
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////
    // DEBUGING
    ///////////////////////////////////////////////////////////////////////////////////////////////
    function getFactories(bytes32 matchEntity) external view returns (bytes32[] memory){
        BotMatchData memory matchInfo = BotMatch.get(matchEntity);
        return matchInfo.factories;
    }

    function numFactories(bytes32 matchEntity) external view returns (uint256){
        BotMatchData memory matchInfo = BotMatch.get(matchEntity);
        return matchInfo.factories.length;
    }

     function getGold(bytes32 matchEntity) external view returns (int32 gold){
        bytes32 player = playerFromAddress(matchEntity, address(this));
        gold = Gold.get(matchEntity, player); // LibGold.getCurrent(matchEntity, player);
    }

    function getTemplateIds(bytes32 matchEntity, bytes32 factoryEntity) external view returns (bytes32[] memory){
        return Factory.getPrototypeIds(matchEntity, factoryEntity);
    }

    function getFactoryPosition(bytes32 matchEntity, bytes32 factoryEntity) external view returns (int32 x, int32 y){
         PositionData memory pos = Position.get(matchEntity, factoryEntity);
         x = pos.x;
         y = pos.y;
    }

    function build(bytes32 matchEntity, bytes32 factoryEntity, bytes32 templateId, int32 x, int32 y) external {
        IWorld world = IWorld(_world());
        bytes32 newUnit = world.build(matchEntity, factoryEntity, templateId, PositionData({x: x, y: y}));
        BotMatch.pushUnits(matchEntity, newUnit);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////

}
