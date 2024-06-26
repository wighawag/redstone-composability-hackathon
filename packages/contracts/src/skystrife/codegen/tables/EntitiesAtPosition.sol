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

library EntitiesAtPosition {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "EntitiesAtPositi", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000456e7469746965734174506f73697469);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, int32, int32)
  Schema constant _keySchema = Schema.wrap(0x002803005f232300000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes32[])
  Schema constant _valueSchema = Schema.wrap(0x00000001c1000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](3);
    keyNames[0] = "matchEntity";
    keyNames[1] = "x";
    keyNames[2] = "y";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "entities";
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
   * @notice Get entities.
   */
  function getEntities(bytes32 matchEntity, int32 x, int32 y) internal view returns (bytes32[] memory entities) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get entities.
   */
  function _getEntities(bytes32 matchEntity, int32 x, int32 y) internal view returns (bytes32[] memory entities) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get entities.
   */
  function get(bytes32 matchEntity, int32 x, int32 y) internal view returns (bytes32[] memory entities) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get entities.
   */
  function _get(bytes32 matchEntity, int32 x, int32 y) internal view returns (bytes32[] memory entities) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Set entities.
   */
  function setEntities(bytes32 matchEntity, int32 x, int32 y, bytes32[] memory entities) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((entities)));
  }

  /**
   * @notice Set entities.
   */
  function _setEntities(bytes32 matchEntity, int32 x, int32 y, bytes32[] memory entities) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((entities)));
  }

  /**
   * @notice Set entities.
   */
  function set(bytes32 matchEntity, int32 x, int32 y, bytes32[] memory entities) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((entities)));
  }

  /**
   * @notice Set entities.
   */
  function _set(bytes32 matchEntity, int32 x, int32 y, bytes32[] memory entities) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((entities)));
  }

  /**
   * @notice Get the length of entities.
   */
  function lengthEntities(bytes32 matchEntity, int32 x, int32 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of entities.
   */
  function _lengthEntities(bytes32 matchEntity, int32 x, int32 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of entities.
   */
  function length(bytes32 matchEntity, int32 x, int32 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of entities.
   */
  function _length(bytes32 matchEntity, int32 x, int32 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get an item of entities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemEntities(bytes32 matchEntity, int32 x, int32 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of entities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemEntities(bytes32 matchEntity, int32 x, int32 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of entities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(bytes32 matchEntity, int32 x, int32 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of entities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(bytes32 matchEntity, int32 x, int32 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Push an element to entities.
   */
  function pushEntities(bytes32 matchEntity, int32 x, int32 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to entities.
   */
  function _pushEntities(bytes32 matchEntity, int32 x, int32 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to entities.
   */
  function push(bytes32 matchEntity, int32 x, int32 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to entities.
   */
  function _push(bytes32 matchEntity, int32 x, int32 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from entities.
   */
  function popEntities(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from entities.
   */
  function _popEntities(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from entities.
   */
  function pop(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from entities.
   */
  function _pop(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Update an element of entities at `_index`.
   */
  function updateEntities(bytes32 matchEntity, int32 x, int32 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of entities at `_index`.
   */
  function _updateEntities(bytes32 matchEntity, int32 x, int32 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of entities at `_index`.
   */
  function update(bytes32 matchEntity, int32 x, int32 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of entities at `_index`.
   */
  function _update(bytes32 matchEntity, int32 x, int32 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 matchEntity, int32 x, int32 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes32[] memory entities) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(entities.length * 32);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes32[] memory entities) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((entities)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes32[] memory entities) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(entities);
    bytes memory _dynamicData = encodeDynamic(entities);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 matchEntity, int32 x, int32 y) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = bytes32(uint256(int256(x)));
    _keyTuple[2] = bytes32(uint256(int256(y)));

    return _keyTuple;
  }
}
