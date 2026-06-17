// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./errors/Errors.sol";

/// @title AgentPassport — On-chain identity NFT for AI agents (Polygon)
/// @notice Each agent wallet gets one passport. Non-transferable after mint.
contract AgentPassport is ERC721, Ownable {
    enum PassportStatus {
        BORN,
        ACTIVE,
        VERIFIED_B2B,
        SUSPENDED
    }

    struct Passport {
        address ipCreator;
        bytes32 ipMetadata;
        PassportStatus status;
        uint64 dailyLimit;
        uint64 currentSpent;
        uint64 lastResetDay;
        uint256 bornAt;
    }

    address public aifinpayCore;
    uint256 private _tokenIdCounter;

    mapping(address => uint256) public agentTokenId;
    mapping(uint256 => Passport) public passports;

    event CoreSet(address indexed core);

    constructor(address initialOwner) ERC721("AiFinPay Agent Passport", "AIPASS") Ownable(initialOwner) {}

    /// @notice Mint a passport for an agent — one per wallet
    function mintPassport(
        address _agent,
        address _ipCreator,
        bytes32 _ipMetadata,
        uint64 _dailyLimit
    ) external onlyCore returns (uint256 tokenId) {
        if (agentTokenId[_agent] != 0) revert PassportAlreadyExists();

        _tokenIdCounter++;
        tokenId = _tokenIdCounter;

        agentTokenId[_agent] = tokenId;
        passports[tokenId] = Passport({
            ipCreator: _ipCreator,
            ipMetadata: _ipMetadata,
            status: PassportStatus.BORN,
            dailyLimit: _dailyLimit,
            currentSpent: 0,
            lastResetDay: uint64(block.timestamp / 1 days),
            bornAt: block.timestamp
        });

        _safeMint(_agent, tokenId);
    }

    /// @notice Set the AiFinPay core contract address — one-time only
    function setCore(address _core) external onlyOwner {
        if (aifinpayCore != address(0)) revert CoreAlreadySet();
        if (_core == address(0)) revert ZeroAddress();
        aifinpayCore = _core;
        emit CoreSet(_core);
    }

    /// @notice Update passport status — admin only via core
    function setStatus(address _agent, PassportStatus _status) external onlyCore {
        uint256 tokenId = agentTokenId[_agent];
        if (tokenId == 0) revert NoPassport();
        passports[tokenId].status = _status;
    }

    /// @notice Check and update daily spend limit
    function updateSpendLimit(address _agent, uint64 _amount) external onlyCore returns (bool) {
        uint256 tokenId = agentTokenId[_agent];
        if (tokenId == 0) revert NoPassport();
        Passport storage p = passports[tokenId];

        uint64 today = uint64(block.timestamp / 1 days);
        if (today > p.lastResetDay) {
            p.currentSpent = 0;
            p.lastResetDay = today;
        }

        if (p.currentSpent + _amount > p.dailyLimit) return false;
        p.currentSpent += _amount;
        return true;
    }

    function getPassport(address _agent) external view returns (Passport memory) {
        uint256 tokenId = agentTokenId[_agent];
        if (tokenId == 0) revert NoPassport();
        return passports[tokenId];
    }

    function hasPassport(address _agent) external view returns (bool) {
        return agentTokenId[_agent] != 0;
    }

    function isVerifiedB2B(address _agent) external view returns (bool) {
        uint256 tokenId = agentTokenId[_agent];
        if (tokenId == 0) return false;
        return passports[tokenId].status == PassportStatus.VERIFIED_B2B;
    }

    /// @notice Soulbound — non-transferable after mint
    function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        if (from != address(0) && to != address(0)) {
            revert Soulbound();
        }
        return super._update(to, tokenId, auth);
    }

    modifier onlyCore() {
        if (msg.sender != aifinpayCore) revert OnlyCore();
        _;
    }
}
