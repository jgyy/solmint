#!/bin/bash

# Solana SPL Token Creation Script
# This script creates a new SPL token on Solana

set -e

echo "================================"
echo "Solana SPL Token Creator"
echo "================================"
echo ""

# Check if Solana CLI is installed
if ! command -v solana &> /dev/null; then
    echo "❌ Solana CLI is not installed."
    echo "Please install it first by running:"
    echo "  curl https://release.solana.com/stable/install | sh"
    exit 1
fi

# Check if spl-token CLI is installed
if ! command -v spl-token &> /dev/null; then
    echo "❌ SPL Token CLI is not installed."
    echo "Installing spl-token CLI..."
    cargo install spl-token-cli
fi

echo "✅ Solana tools verified"
echo ""

# Check if user is configured
SOLANA_CONFIG=$(solana config get | grep "Keypair Path" | awk '{print $3}')
if [ -z "$SOLANA_CONFIG" ]; then
    echo "❌ Solana wallet not configured"
    echo "Run: solana-keygen new"
    exit 1
fi

WALLET_ADDRESS=$(solana address)
echo "📍 Using wallet: $WALLET_ADDRESS"
echo ""

# Get SOL balance
BALANCE=$(solana balance | awk '{print $1}')
echo "💰 SOL Balance: $BALANCE SOL"

if (( $(echo "$BALANCE < 0.02" | bc -l) )); then
    echo "⚠️  Warning: You have less than 0.02 SOL"
    echo "Token creation costs about 0.01 SOL for rent"
    echo "Get testnet SOL from: https://solfaucet.com/"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo ""
echo "=== Token Configuration ==="
echo ""

# Read from token-config.json
TOKEN_NAME=$(cat token-config.json | grep '"name"' | head -1 | sed 's/.*"name": "\(.*\)".*/\1/')
TOKEN_SYMBOL=$(cat token-config.json | grep '"symbol"' | head -1 | sed 's/.*"symbol": "\(.*\)".*/\1/')
DECIMALS=$(cat token-config.json | grep '"decimals"' | sed 's/.*"decimals": \([0-9]*\).*/\1/')
SUPPLY=$(cat token-config.json | grep '"supply"' | grep -v liquidity | sed 's/.*"supply": "\([0-9]*\)".*/\1/')

echo "Token Name: $TOKEN_NAME"
echo "Symbol: $TOKEN_SYMBOL"
echo "Decimals: $DECIMALS"
echo "Total Supply: $SUPPLY"
echo ""

read -p "Is this correct? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Please edit token-config.json and try again"
    exit 1
fi

echo ""
echo "🔄 Creating SPL Token..."
echo ""

# Create token with metadata
# Note: This creates a token on the network specified in your Solana config
TOKEN_ADDRESS=$(spl-token create-token --decimals $DECIMALS | grep "Creating token" | awk '{print $NF}')

if [ -z "$TOKEN_ADDRESS" ]; then
    echo "❌ Failed to create token. Check your Solana configuration."
    exit 1
fi

echo "✅ Token created successfully!"
echo ""
echo "================================"
echo "TOKEN ADDRESS: $TOKEN_ADDRESS"
echo "================================"
echo ""

# Save token address to a file
echo "$TOKEN_ADDRESS" > .token-address

echo "Token address saved to .token-address"
echo ""
echo "Next steps:"
echo "1. Update token-config.json with your token address"
echo "2. Run: bash token/mint-tokens.sh"
echo "3. Create a liquidity pool on Raydium or Jupiter"
echo "4. Deploy your website"
echo ""
echo "For detailed instructions, see: docs/DEPLOYMENT.md"
