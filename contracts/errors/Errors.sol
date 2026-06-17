// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

// ── AiFinPayCore Errors ────────────────────────────────────────────────────────
error ZeroOwner();
error ZeroMSECCO();
error ZeroPassport();
error ZeroTreasury();
error ZeroPartner();
error EmptyPartnerName();
error InvalidAgreementHash();
error ZeroNative();
error InsufficientNativeForFee();
error InvalidPythPrice();
error UnexpectedPriceExponent();
error BelowMinimum();
error UnsupportedToken();
error NoSeatFound();
error PartnerNotActive();
error AgentNotVerifiedB2B();
error PaymentBelowMinimum();
error SpendAmountTooLarge();
error DailySpendLimitExceeded();
error ProtocolFeeFailed();
error MerchantTransferFailed();
error TreasuryTransferFailed();
error IPCreatorTransferFailed();
error BonusAlreadyClaimed();
error NoReferrals();
error FeesExceed100();
error TreasuryFeeTooLow();
error ARPFeeTooHigh();
error ProtocolPaused();

// ── MSECCOToken Errors ─────────────────────────────────────────────────────────
error CoreAlreadySet();
error ZeroAddress();
error OnlyCore();
error NonTransferable();

// ── AgentPassport Errors ───────────────────────────────────────────────────────
error PassportAlreadyExists();
error NoPassport();
error Soulbound();

// ── B2BSplitter Errors ─────────────────────────────────────────────────────────
error ZeroAmount();
error ZeroMerchant();
error PaymentTooSmall();
error PaymentTooSmallForTreasury();
error PaymentTooSmallForRoyalty();
error PaymentTooSmallForMerchant();
