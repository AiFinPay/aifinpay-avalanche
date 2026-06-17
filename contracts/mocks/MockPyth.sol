// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

/// @dev Mock Pyth oracle for local testing only — never deploy to mainnet
contract MockPyth {
    struct Price {
        int64 price;
        uint64 conf;
        int32 expo;
        uint publishTime;
    }

    // Fixed MATIC/USD = $0.50 (50_000_000 with expo -8)
    int64 public mockPrice = 50_000_000;
    int32 public mockExpo = -8;

    function setMockPrice(int64 _price) external {
        mockPrice = _price;
    }

    function getUpdateFee(bytes[] calldata) external pure returns (uint) {
        return 1; // 1 wei
    }

    function updatePriceFeeds(bytes[] calldata) external payable {
        // no-op
    }

    function getPriceNoOlderThan(bytes32, uint) external view returns (Price memory) {
        return Price({price: mockPrice, conf: 100_000, expo: mockExpo, publishTime: block.timestamp});
    }
}
