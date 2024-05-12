// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema } from "@latticexyz/store/src/Schema.sol";
import { EncodedLengths, EncodedLengthsLib } from "@latticexyz/store/src/EncodedLengths.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

struct CombatOutcomeData {
  bytes32 attacker;
  bytes32 defender;
  int32 attackerDamageReceived;
  int32 defenderDamageReceived;
  int32 attackerDamage;
  int32 defenderDamage;
  bool ranged;
  bool attackerDied;
  bool defenderDied;
  bool defenderCaptured;
  uint256 blockNumber;
  uint256 timestamp;
}

library CombatOutcome {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "CombatOutcome", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000436f6d6261744f7574636f6d65000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x00940c0020200404040401010101202000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, bytes32)
  Schema constant _keySchema = Schema.wrap(0x004002005f5f0000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes32, bytes32, int32, int32, int32, int32, bool, bool, bool, bool, uint256, uint256)
  Schema constant _valueSchema = Schema.wrap(0x00940c005f5f23232323606060601f1f00000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "matchEntity";
    keyNames[1] = "entity";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](12);
    fieldNames[0] = "attacker";
    fieldNames[1] = "defender";
    fieldNames[2] = "attackerDamageReceived";
    fieldNames[3] = "defenderDamageReceived";
    fieldNames[4] = "attackerDamage";
    fieldNames[5] = "defenderDamage";
    fieldNames[6] = "ranged";
    fieldNames[7] = "attackerDied";
    fieldNames[8] = "defenderDied";
    fieldNames[9] = "defenderCaptured";
    fieldNames[10] = "blockNumber";
    fieldNames[11] = "timestamp";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get attacker.
   */
  function getAttacker(bytes32 matchEntity, bytes32 entity) internal view returns (bytes32 attacker) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Get attacker.
   */
  function _getAttacker(bytes32 matchEntity, bytes32 entity) internal view returns (bytes32 attacker) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Set attacker.
   */
  function setAttacker(bytes32 matchEntity, bytes32 entity, bytes32 attacker) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((attacker)), _fieldLayout);
  }

  /**
   * @notice Set attacker.
   */
  function _setAttacker(bytes32 matchEntity, bytes32 entity, bytes32 attacker) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((attacker)), _fieldLayout);
  }

  /**
   * @notice Get defender.
   */
  function getDefender(bytes32 matchEntity, bytes32 entity) internal view returns (bytes32 defender) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Get defender.
   */
  function _getDefender(bytes32 matchEntity, bytes32 entity) internal view returns (bytes32 defender) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Set defender.
   */
  function setDefender(bytes32 matchEntity, bytes32 entity, bytes32 defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((defender)), _fieldLayout);
  }

  /**
   * @notice Set defender.
   */
  function _setDefender(bytes32 matchEntity, bytes32 entity, bytes32 defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((defender)), _fieldLayout);
  }

  /**
   * @notice Get attackerDamageReceived.
   */
  function getAttackerDamageReceived(
    bytes32 matchEntity,
    bytes32 entity
  ) internal view returns (int32 attackerDamageReceived) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Get attackerDamageReceived.
   */
  function _getAttackerDamageReceived(
    bytes32 matchEntity,
    bytes32 entity
  ) internal view returns (int32 attackerDamageReceived) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Set attackerDamageReceived.
   */
  function setAttackerDamageReceived(bytes32 matchEntity, bytes32 entity, int32 attackerDamageReceived) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((attackerDamageReceived)), _fieldLayout);
  }

  /**
   * @notice Set attackerDamageReceived.
   */
  function _setAttackerDamageReceived(bytes32 matchEntity, bytes32 entity, int32 attackerDamageReceived) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((attackerDamageReceived)), _fieldLayout);
  }

  /**
   * @notice Get defenderDamageReceived.
   */
  function getDefenderDamageReceived(
    bytes32 matchEntity,
    bytes32 entity
  ) internal view returns (int32 defenderDamageReceived) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Get defenderDamageReceived.
   */
  function _getDefenderDamageReceived(
    bytes32 matchEntity,
    bytes32 entity
  ) internal view returns (int32 defenderDamageReceived) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Set defenderDamageReceived.
   */
  function setDefenderDamageReceived(bytes32 matchEntity, bytes32 entity, int32 defenderDamageReceived) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((defenderDamageReceived)), _fieldLayout);
  }

  /**
   * @notice Set defenderDamageReceived.
   */
  function _setDefenderDamageReceived(bytes32 matchEntity, bytes32 entity, int32 defenderDamageReceived) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((defenderDamageReceived)), _fieldLayout);
  }

  /**
   * @notice Get attackerDamage.
   */
  function getAttackerDamage(bytes32 matchEntity, bytes32 entity) internal view returns (int32 attackerDamage) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Get attackerDamage.
   */
  function _getAttackerDamage(bytes32 matchEntity, bytes32 entity) internal view returns (int32 attackerDamage) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Set attackerDamage.
   */
  function setAttackerDamage(bytes32 matchEntity, bytes32 entity, int32 attackerDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((attackerDamage)), _fieldLayout);
  }

  /**
   * @notice Set attackerDamage.
   */
  function _setAttackerDamage(bytes32 matchEntity, bytes32 entity, int32 attackerDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((attackerDamage)), _fieldLayout);
  }

  /**
   * @notice Get defenderDamage.
   */
  function getDefenderDamage(bytes32 matchEntity, bytes32 entity) internal view returns (int32 defenderDamage) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Get defenderDamage.
   */
  function _getDefenderDamage(bytes32 matchEntity, bytes32 entity) internal view returns (int32 defenderDamage) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Set defenderDamage.
   */
  function setDefenderDamage(bytes32 matchEntity, bytes32 entity, int32 defenderDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((defenderDamage)), _fieldLayout);
  }

  /**
   * @notice Set defenderDamage.
   */
  function _setDefenderDamage(bytes32 matchEntity, bytes32 entity, int32 defenderDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((defenderDamage)), _fieldLayout);
  }

  /**
   * @notice Get ranged.
   */
  function getRanged(bytes32 matchEntity, bytes32 entity) internal view returns (bool ranged) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 6, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get ranged.
   */
  function _getRanged(bytes32 matchEntity, bytes32 entity) internal view returns (bool ranged) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 6, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set ranged.
   */
  function setRanged(bytes32 matchEntity, bytes32 entity, bool ranged) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((ranged)), _fieldLayout);
  }

  /**
   * @notice Set ranged.
   */
  function _setRanged(bytes32 matchEntity, bytes32 entity, bool ranged) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((ranged)), _fieldLayout);
  }

  /**
   * @notice Get attackerDied.
   */
  function getAttackerDied(bytes32 matchEntity, bytes32 entity) internal view returns (bool attackerDied) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 7, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get attackerDied.
   */
  function _getAttackerDied(bytes32 matchEntity, bytes32 entity) internal view returns (bool attackerDied) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 7, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set attackerDied.
   */
  function setAttackerDied(bytes32 matchEntity, bytes32 entity, bool attackerDied) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 7, abi.encodePacked((attackerDied)), _fieldLayout);
  }

  /**
   * @notice Set attackerDied.
   */
  function _setAttackerDied(bytes32 matchEntity, bytes32 entity, bool attackerDied) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 7, abi.encodePacked((attackerDied)), _fieldLayout);
  }

  /**
   * @notice Get defenderDied.
   */
  function getDefenderDied(bytes32 matchEntity, bytes32 entity) internal view returns (bool defenderDied) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 8, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get defenderDied.
   */
  function _getDefenderDied(bytes32 matchEntity, bytes32 entity) internal view returns (bool defenderDied) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 8, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set defenderDied.
   */
  function setDefenderDied(bytes32 matchEntity, bytes32 entity, bool defenderDied) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 8, abi.encodePacked((defenderDied)), _fieldLayout);
  }

  /**
   * @notice Set defenderDied.
   */
  function _setDefenderDied(bytes32 matchEntity, bytes32 entity, bool defenderDied) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 8, abi.encodePacked((defenderDied)), _fieldLayout);
  }

  /**
   * @notice Get defenderCaptured.
   */
  function getDefenderCaptured(bytes32 matchEntity, bytes32 entity) internal view returns (bool defenderCaptured) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 9, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get defenderCaptured.
   */
  function _getDefenderCaptured(bytes32 matchEntity, bytes32 entity) internal view returns (bool defenderCaptured) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 9, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set defenderCaptured.
   */
  function setDefenderCaptured(bytes32 matchEntity, bytes32 entity, bool defenderCaptured) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 9, abi.encodePacked((defenderCaptured)), _fieldLayout);
  }

  /**
   * @notice Set defenderCaptured.
   */
  function _setDefenderCaptured(bytes32 matchEntity, bytes32 entity, bool defenderCaptured) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 9, abi.encodePacked((defenderCaptured)), _fieldLayout);
  }

  /**
   * @notice Get blockNumber.
   */
  function getBlockNumber(bytes32 matchEntity, bytes32 entity) internal view returns (uint256 blockNumber) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 10, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get blockNumber.
   */
  function _getBlockNumber(bytes32 matchEntity, bytes32 entity) internal view returns (uint256 blockNumber) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 10, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set blockNumber.
   */
  function setBlockNumber(bytes32 matchEntity, bytes32 entity, uint256 blockNumber) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 10, abi.encodePacked((blockNumber)), _fieldLayout);
  }

  /**
   * @notice Set blockNumber.
   */
  function _setBlockNumber(bytes32 matchEntity, bytes32 entity, uint256 blockNumber) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 10, abi.encodePacked((blockNumber)), _fieldLayout);
  }

  /**
   * @notice Get timestamp.
   */
  function getTimestamp(bytes32 matchEntity, bytes32 entity) internal view returns (uint256 timestamp) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 11, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get timestamp.
   */
  function _getTimestamp(bytes32 matchEntity, bytes32 entity) internal view returns (uint256 timestamp) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 11, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set timestamp.
   */
  function setTimestamp(bytes32 matchEntity, bytes32 entity, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 11, abi.encodePacked((timestamp)), _fieldLayout);
  }

  /**
   * @notice Set timestamp.
   */
  function _setTimestamp(bytes32 matchEntity, bytes32 entity, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 11, abi.encodePacked((timestamp)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 matchEntity, bytes32 entity) internal view returns (CombatOutcomeData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 matchEntity, bytes32 entity) internal view returns (CombatOutcomeData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    bytes32 matchEntity,
    bytes32 entity,
    bytes32 attacker,
    bytes32 defender,
    int32 attackerDamageReceived,
    int32 defenderDamageReceived,
    int32 attackerDamage,
    int32 defenderDamage,
    bool ranged,
    bool attackerDied,
    bool defenderDied,
    bool defenderCaptured,
    uint256 blockNumber,
    uint256 timestamp
  ) internal {
    bytes memory _staticData = encodeStatic(
      attacker,
      defender,
      attackerDamageReceived,
      defenderDamageReceived,
      attackerDamage,
      defenderDamage,
      ranged,
      attackerDied,
      defenderDied,
      defenderCaptured,
      blockNumber,
      timestamp
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 matchEntity,
    bytes32 entity,
    bytes32 attacker,
    bytes32 defender,
    int32 attackerDamageReceived,
    int32 defenderDamageReceived,
    int32 attackerDamage,
    int32 defenderDamage,
    bool ranged,
    bool attackerDied,
    bool defenderDied,
    bool defenderCaptured,
    uint256 blockNumber,
    uint256 timestamp
  ) internal {
    bytes memory _staticData = encodeStatic(
      attacker,
      defender,
      attackerDamageReceived,
      defenderDamageReceived,
      attackerDamage,
      defenderDamage,
      ranged,
      attackerDied,
      defenderDied,
      defenderCaptured,
      blockNumber,
      timestamp
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 matchEntity, bytes32 entity, CombatOutcomeData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.attacker,
      _table.defender,
      _table.attackerDamageReceived,
      _table.defenderDamageReceived,
      _table.attackerDamage,
      _table.defenderDamage,
      _table.ranged,
      _table.attackerDied,
      _table.defenderDied,
      _table.defenderCaptured,
      _table.blockNumber,
      _table.timestamp
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 matchEntity, bytes32 entity, CombatOutcomeData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.attacker,
      _table.defender,
      _table.attackerDamageReceived,
      _table.defenderDamageReceived,
      _table.attackerDamage,
      _table.defenderDamage,
      _table.ranged,
      _table.attackerDied,
      _table.defenderDied,
      _table.defenderCaptured,
      _table.blockNumber,
      _table.timestamp
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  )
    internal
    pure
    returns (
      bytes32 attacker,
      bytes32 defender,
      int32 attackerDamageReceived,
      int32 defenderDamageReceived,
      int32 attackerDamage,
      int32 defenderDamage,
      bool ranged,
      bool attackerDied,
      bool defenderDied,
      bool defenderCaptured,
      uint256 blockNumber,
      uint256 timestamp
    )
  {
    attacker = (Bytes.getBytes32(_blob, 0));

    defender = (Bytes.getBytes32(_blob, 32));

    attackerDamageReceived = (int32(uint32(Bytes.getBytes4(_blob, 64))));

    defenderDamageReceived = (int32(uint32(Bytes.getBytes4(_blob, 68))));

    attackerDamage = (int32(uint32(Bytes.getBytes4(_blob, 72))));

    defenderDamage = (int32(uint32(Bytes.getBytes4(_blob, 76))));

    ranged = (_toBool(uint8(Bytes.getBytes1(_blob, 80))));

    attackerDied = (_toBool(uint8(Bytes.getBytes1(_blob, 81))));

    defenderDied = (_toBool(uint8(Bytes.getBytes1(_blob, 82))));

    defenderCaptured = (_toBool(uint8(Bytes.getBytes1(_blob, 83))));

    blockNumber = (uint256(Bytes.getBytes32(_blob, 84)));

    timestamp = (uint256(Bytes.getBytes32(_blob, 116)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths,
    bytes memory
  ) internal pure returns (CombatOutcomeData memory _table) {
    (
      _table.attacker,
      _table.defender,
      _table.attackerDamageReceived,
      _table.defenderDamageReceived,
      _table.attackerDamage,
      _table.defenderDamage,
      _table.ranged,
      _table.attackerDied,
      _table.defenderDied,
      _table.defenderCaptured,
      _table.blockNumber,
      _table.timestamp
    ) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 matchEntity, bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 matchEntity, bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    bytes32 attacker,
    bytes32 defender,
    int32 attackerDamageReceived,
    int32 defenderDamageReceived,
    int32 attackerDamage,
    int32 defenderDamage,
    bool ranged,
    bool attackerDied,
    bool defenderDied,
    bool defenderCaptured,
    uint256 blockNumber,
    uint256 timestamp
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        attacker,
        defender,
        attackerDamageReceived,
        defenderDamageReceived,
        attackerDamage,
        defenderDamage,
        ranged,
        attackerDied,
        defenderDied,
        defenderCaptured,
        blockNumber,
        timestamp
      );
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    bytes32 attacker,
    bytes32 defender,
    int32 attackerDamageReceived,
    int32 defenderDamageReceived,
    int32 attackerDamage,
    int32 defenderDamage,
    bool ranged,
    bool attackerDied,
    bool defenderDied,
    bool defenderCaptured,
    uint256 blockNumber,
    uint256 timestamp
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(
      attacker,
      defender,
      attackerDamageReceived,
      defenderDamageReceived,
      attackerDamage,
      defenderDamage,
      ranged,
      attackerDied,
      defenderDied,
      defenderCaptured,
      blockNumber,
      timestamp
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 matchEntity, bytes32 entity) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    return _keyTuple;
  }
}

/**
 * @notice Cast a value to a bool.
 * @dev Boolean values are encoded as uint8 (1 = true, 0 = false), but Solidity doesn't allow casting between uint8 and bool.
 * @param value The uint8 value to convert.
 * @return result The boolean value.
 */
function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
