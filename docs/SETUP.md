# Setup Guide - SolMint on Solana

This guide will walk you through setting up your environment to create and deploy your token on Solana.

## Prerequisites

Before you begin, make sure you have:
- A computer (Windows, macOS, or Linux)
- Internet connection
- A code editor (VS Code recommended)
- Basic command line knowledge

## Step 1: Install Solana CLI

Solana CLI is the main tool for interacting with Solana blockchain.

### macOS / Linux
```bash
curl https://release.solana.com/stable/install | sh
```

Then add Solana to your PATH:
```bash
export PATH="/home/USERNAME/.local/share/solana/install/active_release/bin:$PATH"
```

### Windows
Download and run the installer from: https://docs.solana.com/cli/install-solana-tool-suite

### Verify Installation
```bash
solana --version
```

You should see the version number (e.g., `solana-cli 1.18.0`).

## Step 2: Create a Solana Wallet

Create a new keypair (wallet) for your token operations:

```bash
solana-keygen new
```

You'll be prompted to create a password and shown your recovery phrase. **SAVE THIS PHRASE IN A SAFE PLACE!**

Verify your wallet:
```bash
solana address
```

This outputs your public address (wallet address).

## Step 3: Set Up Solana Network

By default, Solana CLI is set to mainnet. You can switch between networks:

### Use Devnet (for testing)
```bash
solana config set --url https://api.devnet.solana.com
```

### Use Mainnet-Beta (real tokens)
```bash
solana config set --url https://api.mainnet-beta.solana.com
```

### View Current Configuration
```bash
solana config get
```

## Step 4: Get SOL for Fees

You need SOL in your wallet to pay for:
- Token creation (~0.01 SOL / ~$2-3)
- Associated token accounts (~0.002 SOL)
- Metadata storage (~0.005 SOL)

**Total needed: ~0.02-0.05 SOL (~$5-15)**

### Get Free SOL on Devnet
If testing on devnet first:
```bash
solana airdrop 2
```

Or use faucet: https://solfaucet.com/

### Get SOL for Mainnet
1. Purchase SOL from an exchange:
   - Coinbase
   - Kraken
   - Binance
   - OKX

2. Send to your wallet address (from `solana address`)

### Check Balance
```bash
solana balance
```

## Step 5: Install SPL Token CLI

SPL Token CLI is used to create and manage tokens:

```bash
cargo install spl-token-cli
```

If you don't have Rust installed, install it first:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Verify installation:
```bash
spl-token --version
```

## Step 6: Clone or Download This Repository

If you haven't already, clone this repository:

```bash
git clone https://github.com/solmint/blockchain0.git
cd blockchain0
```

Or download it as ZIP and extract.

## Step 7: Configure Your Token

Edit `token/token-config.json` with your token details:

```json
{
  "token": {
    "name": "SolMint",
    "symbol": "MINT",
    "description": "Launch your own Solana token in minutes",
    "decimals": 6,
    "supply": "1000000000",
    "logoUrl": "https://your-logo-url.com/logo.png"
  },
  "social": {
    "twitter": "https://twitter.com/solmint_io",
    "telegram": "https://t.me/solmint",
    "discord": "https://discord.gg/solmint",
    "website": "https://solmint.io"
  }
}
```

## Step 8: Make Scripts Executable

On macOS and Linux:

```bash
chmod +x token/create-token.sh
chmod +x token/mint-tokens.sh
chmod +x token/setup-liquidity.sh
```

## Step 9: Test Your Setup

Run a quick test to ensure everything is working:

```bash
solana address
solana balance
spl-token --version
```

All three commands should work without errors.

## Troubleshooting

### "solana: command not found"
- Solution: Add Solana to your PATH environment variable
- Restart your terminal after installing

### "Insufficient SOL balance"
- Get more SOL from a faucet or purchase from exchange
- Make sure you're on the correct network

### "spl-token: command not found"
- Reinstall: `cargo install spl-token-cli`
- Make sure Rust is installed: `rustc --version`

### RPC Connection Issues
- Try switching to a different RPC endpoint
- Check Solana network status: https://status.solana.com/

### Permission Denied
- On macOS/Linux: Run `chmod +x *.sh` in the token folder

## Next Steps

1. Read `docs/DEPLOYMENT.md` for token creation instructions
2. Customize `website/index.html` with your token details
3. Deploy your website to GitHub Pages
4. Create liquidity pool on Raydium or Jupiter
5. Build your community!

## Important Security Notes

⚠️ **Security Tips:**
- Never share your recovery phrase or private key
- Keep your wallet password secure
- Always verify URLs before entering private keys
- Test everything on devnet first
- Use multi-signature wallets for high-value operations
- Keep backup of your recovery phrase in multiple secure locations

## Resources

- [Solana Official Docs](https://docs.solana.com/)
- [SPL Token Program](https://spl.solana.com/token)
- [Solana CLI Reference](https://docs.solana.com/cli)
- [Phantom Wallet](https://phantom.app/)
- [Solana Devnet Faucet](https://solfaucet.com/)

## Support

If you encounter issues:
1. Check Solana documentation
2. Search GitHub issues
3. Join Solana Discord: https://discord.gg/solana
4. Create an issue in this repository

Good luck with your token launch! 🚀
