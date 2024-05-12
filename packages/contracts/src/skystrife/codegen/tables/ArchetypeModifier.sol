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

// Import user types
import { CombatArchetypes } from "./../common.sol";

struct ArchetypeModifierData {
  int32 mod;
  CombatArchetypes attackerArchetype;
  CombatArchetypes defenderArchetype;
}

library ArchetypeModifier {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "ArchetypeModifie", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746200000000000000000000000000004172636865747970654d6f6469666965);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0006030004010100000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (uint8, uint8)
  Schema constant _keySchema = Schema.wrap(0x0002020000000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (int32, uint8, uint8)
  Schema constant _valueSchema = Schema.wrap(0x0006030023000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "attacker";
    keyNames[1] = "defender";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "mod";
    fieldNames[1] = "attackerArchetype";
    fieldNames[2] = "defenderArchetype";
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
   * @notice Get mod.
   */
  function getMod(CombatArchetypes attacker, CombatArchetypes defender) internal view returns (int32 mod) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Get mod.
   */
  function _getMod(CombatArchetypes attacker, CombatArchetypes defender) internal view returns (int32 mod) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (int32(uint32(bytes4(_blob))));
  }

  /**
   * @notice Set mod.
   */
  function setMod(CombatArchetypes attacker, CombatArchetypes defender, int32 mod) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((mod)), _fieldLayout);
  }

  /**
   * @notice Set mod.
   */
  function _setMod(CombatArchetypes attacker, CombatArchetypes defender, int32 mod) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((mod)), _fieldLayout);
  }

  /**
   * @notice Get attackerArchetype.
   */
  function getAttackerArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (CombatArchetypes attackerArchetype) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return CombatArchetypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Get attackerArchetype.
   */
  function _getAttackerArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (CombatArchetypes attackerArchetype) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return CombatArchetypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Set attackerArchetype.
   */
  function setAttackerArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender,
    CombatArchetypes attackerArchetype
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked(uint8(attackerArchetype)), _fieldLayout);
  }

  /**
   * @notice Set attackerArchetype.
   */
  function _setAttackerArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender,
    CombatArchetypes attackerArchetype
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked(uint8(attackerArchetype)), _fieldLayout);
  }

  /**
   * @notice Get defenderArchetype.
   */
  function getDefenderArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (CombatArchetypes defenderArchetype) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return CombatArchetypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Get defenderArchetype.
   */
  function _getDefenderArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (CombatArchetypes defenderArchetype) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return CombatArchetypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Set defenderArchetype.
   */
  function setDefenderArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender,
    CombatArchetypes defenderArchetype
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked(uint8(defenderArchetype)), _fieldLayout);
  }

  /**
   * @notice Set defenderArchetype.
   */
  function _setDefenderArchetype(
    CombatArchetypes attacker,
    CombatArchetypes defender,
    CombatArchetypes defenderArchetype
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked(uint8(defenderArchetype)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (ArchetypeModifierData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

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
  function _get(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal view returns (ArchetypeModifierData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

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
    CombatArchetypes attacker,
    CombatArchetypes defender,
    int32 mod,
    CombatArchetypes attackerArchetype,
    CombatArchetypes defenderArchetype
  ) internal {
    bytes memory _staticData = encodeStatic(mod, attackerArchetype, defenderArchetype);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    CombatArchetypes attacker,
    CombatArchetypes defender,
    int32 mod,
    CombatArchetypes attackerArchetype,
    CombatArchetypes defenderArchetype
  ) internal {
    bytes memory _staticData = encodeStatic(mod, attackerArchetype, defenderArchetype);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(CombatArchetypes attacker, CombatArchetypes defender, ArchetypeModifierData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.mod, _table.attackerArchetype, _table.defenderArchetype);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(CombatArchetypes attacker, CombatArchetypes defender, ArchetypeModifierData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.mod, _table.attackerArchetype, _table.defenderArchetype);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (int32 mod, CombatArchetypes attackerArchetype, CombatArchetypes defenderArchetype) {
    mod = (int32(uint32(Bytes.getBytes4(_blob, 0))));

    attackerArchetype = CombatArchetypes(uint8(Bytes.getBytes1(_blob, 4)));

    defenderArchetype = CombatArchetypes(uint8(Bytes.getBytes1(_blob, 5)));
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
  ) internal pure returns (ArchetypeModifierData memory _table) {
    (_table.mod, _table.attackerArchetype, _table.defenderArchetype) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(CombatArchetypes attacker, CombatArchetypes defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(CombatArchetypes attacker, CombatArchetypes defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    int32 mod,
    CombatArchetypes attackerArchetype,
    CombatArchetypes defenderArchetype
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(mod, attackerArchetype, defenderArchetype);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    int32 mod,
    CombatArchetypes attackerArchetype,
    CombatArchetypes defenderArchetype
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(mod, attackerArchetype, defenderArchetype);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(
    CombatArchetypes attacker,
    CombatArchetypes defender
  ) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint8(attacker)));
    _keyTuple[1] = bytes32(uint256(uint8(defender)));

    return _keyTuple;
  }
}