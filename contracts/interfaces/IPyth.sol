// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

/// @title Pyth Pull Oracle Interface
/// @notice Interface for Pyth Network pull oracle on Polygon
interface IPyth {
    struct Price {
        int64 price;
        uint64 conf;
        int32 expo;
        uint publishTime;
    }

    function getUpdateFee(bytes[] calldata updateData) external view returns (uint feeAmount);
    function updatePriceFeeds(bytes[] calldata updateData) external payable;
    function getPriceNoOlderThan(bytes32 id, uint age) external view returns (Price memory price);
}
