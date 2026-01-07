#!/bin/bash

# Solana SPL Token Minting Script
# This script mints your token supply

set -e

echo "================================"
echo "Solana SPL Token Minter"
echo "================================"
echo ""

# Check if token address file exists
if [ ! -f ".token-address" ]; then
    echo "❌ Token address not found"
    echo "Run create-token.sh first to create a token"
    exit 1
fi

TOKEN_ADDRESS=$(cat .token-address)
WALLET_ADDRESS=$(solana address)

echo "📍 Token Address: $TOKEN_ADDRESS"
echo "📍 Wallet: $WALLET_ADDRESS"
echo ""

# Read configuration
SUPPLY=$(cat token/token-config.json | grep '"supply"' | grep -v liquidity | sed 's/.*"supply": "\([0-9]*\)".*/\1/')
DECIMALS=$(cat token/token-config.json | grep '"decimals"' | sed 's/.*"decimals": \([0-9]*\).*/\1/')

echo "💰 Total Supply: $SUPPLY tokens"
echo "🔢 Decimals: $DECIMALS"
echo ""

# Calculate actual amount with decimals
# For 6 decimals: multiply by 10^6
AMOUNT_WITH_DECIMALS=$(echo "$SUPPLY * 10^$DECIMALS" | bc)

echo "Will mint: $AMOUNT_WITH_DECIMALS (with decimals)"
echo ""

read -p "Continue with minting? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo "🔄 Minting tokens..."

# First, create associated token account for your wallet
ATA_ADDRESS=$(spl-token create-account $TOKEN_ADDRESS | grep "Creating account" | awk '{print $NF}')

echo "✅ Associated token account created: $ATA_ADDRESS"
echo ""

# Mint tokens to your account
spl-token mint $TOKEN_ADDRESS $SUPPLY --recipient-owner $WALLET_ADDRESS

echo ""
echo "✅ Tokens minted successfully!"
echo ""
echo "Your token is now ready to use:"
echo "- Token Address: $TOKEN_ADDRESS"
echo "- Your Account: $ATA_ADDRESS"
echo "- Balance: $SUPPLY tokens"
echo ""
echo "Next steps:"
echo "1. Review docs/DEPLOYMENT.md for liquidity pool setup"
echo "2. Create liquidity on Raydium: https://raydium.io"
echo "3. Deploy your website to GitHub Pages"
echo ""
