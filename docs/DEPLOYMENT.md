# Token Deployment Guide

This guide walks you through creating and deploying your SPL token on Solana mainnet.

**Important**: Complete the setup in `docs/SETUP.md` before following this guide.

## Overview

The token creation process involves:
1. Creating the SPL token
2. Minting your token supply
3. Creating a liquidity pool
4. Publishing to DEXs

## Step 1: Prepare Your Configuration

Make sure you've edited `token/token-config.json` with your token details:

```bash
cat token/token-config.json
```

Key fields to configure:
- `name`: Your token name (e.g., "Awesome Token")
- `symbol`: 3-5 character symbol (e.g., "AWESOME")
- `decimals`: Usually 6 for SPL tokens
- `supply`: Total supply in base units (e.g., "1000000000" = 1 billion)
- `logoUrl`: URL to your token logo

## Step 2: Verify Your Wallet is Ready

Check that you have enough SOL for fees:

```bash
solana address
solana balance
```

You should have at least **0.05 SOL** to safely create and mint a token.

## Step 3: Create Your Token

Run the token creation script:

```bash
cd token
bash create-token.sh
```

The script will:
1. Verify your Solana setup
2. Show your configuration
3. Create the token
4. Save the token address to `.token-address`

Example output:
```
================================
TOKEN ADDRESS: 9j1v2c3k5m7p9q2w4e6r8t0y3u5i7o9l
================================
```

**Save this token address!** You'll need it for:
- Creating liquidity pools
- Website configuration
- Social media mentions

## Step 4: Mint Your Token Supply

Now mint your token's supply:

```bash
bash mint-tokens.sh
```

This script:
1. Reads your token address
2. Creates an associated token account
3. Mints the total supply to your account

The tokens are now in your wallet, ready for liquidity.

## Step 5: Create a Liquidity Pool

This is the most important step for making your token tradeable.

### Option A: Use Raydium (Recommended)

1. Go to [Raydium.io](https://raydium.io)
2. Connect your wallet (Phantom, Solflare, etc.)
3. Click "Create Pool"
4. Select your token as one of the pair (e.g., MINT/SOL)
5. Set initial liquidity:
   - SOL amount: 2-5 SOL ($50-150)
   - Token amount: Depends on your tokenomics
   - Example: 5 SOL + 100,000,000 MINT
6. Review and confirm transaction
7. Your pool is now live!

### Option B: Use Jupiter

1. Go to [Jupiter.ag](https://jup.ag)
2. Similar process to Raydium
3. Good for market making and liquidity

### Important Liquidity Guidelines

- **Start small**: Begin with 2-5 SOL of liquidity
- **Fair pricing**: Set token price reasonably
  - If 1 SOL = $25, and you have 100M tokens, price = 0.00000025 SOL per token
- **Lock liquidity** (optional): Consider Marinade or Orca for LP token locks
- **Gradual increase**: Add more liquidity as trading volume grows

## Step 6: Update Your Website

Update `website/index.html` with your token address:

```html
<code id="contract-address">YOUR_ACTUAL_TOKEN_ADDRESS</code>
```

Replace `YOUR_ACTUAL_TOKEN_ADDRESS` with your actual token address from step 3.

Also update:
- Token name: `SolMint`
- Symbol: `MINT`
- Social links (Twitter, Telegram, Discord)
- Logo URL

## Step 7: Deploy Website

### Using GitHub Pages (Free & Easy)

1. Create a GitHub account (if you don't have one)
2. Create a new public repository named `blockchain0`
3. Go to repository settings → Pages
4. Set source to `main` branch, root folder
5. Your site will be at: `https://YOUR_GITHUB_USERNAME.github.io/blockchain0`

### Alternative: Use Vercel (Free)

1. Go to [vercel.com](https://vercel.com)
2. Click "Import Project"
3. Import your GitHub repository
4. Deploy

### Alternative: Use Netlify (Free)

1. Go to [netlify.com](https://netlify.com)
2. Drag and drop your `website` folder
3. Site is live immediately

## Step 8: List on DEX Aggregators

Make your token discoverable on trading platforms:

### DexScreener (Free)
1. Go to [DexScreener.com](https://dexscreener.com)
2. Search your token address
3. Click "Create page" if not found
4. Add website, social links, logo
5. Instant visibility to traders

### Jupiter (Automatic)
- Jupiter automatically lists most Solana tokens
- Your token appears after first trades

### Raydium (Automatic)
- Listed automatically if pool created on Raydium

### CoinGecko (Optional)
1. Go to [coingecko.com](https://coingecko.com)
2. Click "Request Listing"
3. Fill out information
4. May take 1-2 weeks for approval
5. Great for credibility

### CoinMarketCap (Optional)
1. Go to [coinmarketcap.com](https://coinmarketcap.com)
2. Sign up and submit token
3. Similar process to CoinGecko

## Step 9: Build Community

With your token live, start building community:

### Social Media Setup
- **Twitter/X**: Share updates, memes, milestones
- **Telegram**: Create group for community chat
- **Discord**: More detailed community features

### Community Engagement
- Share your token launch
- Engage with Solana community
- Post updates regularly
- Respond to questions

### Initial Marketing
- Post in Solana subreddits: r/solana, r/SolanaNFTs
- Share on crypto twitter
- Join Solana Discord servers
- Post in Telegram groups
- Consider small bounty program for social shares

## Monitoring Your Token

### Check Token Statistics
```bash
# View token supply
spl-token supply YOUR_ACTUAL_TOKEN_ADDRESS

# View account balance
spl-token balance YOUR_ACTUAL_TOKEN_ADDRESS

# View token metadata
spl-token display YOUR_ACTUAL_TOKEN_ADDRESS
```

### Monitor Trading
- Check DexScreener for charts
- Monitor volume and price
- Watch for large holders

## Selling Your Tokens

### Safe Selling Strategy
1. **Start small**: Sell 1-5% of your allocation first
2. **Gradual**: Spread sales over time
3. **Monitor impact**: Watch price effect of your sales
4. **Build trust**: Show you believe in the project

### Using Jupiter to Sell
1. Go to [Jupiter.ag](https://jup.ag)
2. Select SolMint as input
3. Select SOL as output
4. Enter amount and swap

## Troubleshooting

### "Transaction failed"
- You may have insufficient SOL for fees
- Network might be congested
- Try again in a few moments

### "Token not appearing in wallet"
- Wallet may not recognize new tokens automatically
- Add token address manually in wallet settings
- Switch networks and back

### "Cannot create liquidity pool"
- Verify you have minted tokens
- Ensure you have enough SOL
- Try a different DEX

### Pool shows $0 volume
- Normal for new tokens
- Promote to potential traders
- Ensure liquidity is adequate
- Price should be reasonable

## Cost Breakdown

Total costs for token creation:

| Item | Cost |
|------|------|
| Token creation | ~0.01 SOL ($0.25) |
| Minting tokens | ~0.002 SOL ($0.05) |
| Liquidity pool creation | Free |
| Initial liquidity | ~2-5 SOL ($50-125) |
| **Total** | **~2.01 SOL ($50-125)** |

## Next Steps

After deployment:
1. Read `docs/MARKETING.md` for growth strategies
2. Engage with your community
3. Plan utility or additional features
4. Consider DAO governance later
5. Explore partnerships

## Important Reminders

⚠️ **Remember:**
- Be transparent about tokenomics
- Communicate regularly with community
- Avoid pump-and-dump schemes (illegal in most jurisdictions)
- Don't make guarantees about price
- Follow all local laws and regulations
- This is high-risk; most tokens don't succeed
- Take profits responsibly

## Resources

- [Solana Explorer](https://explorer.solana.com)
- [Raydium Docs](https://docs.raydium.io)
- [Jupiter Swap](https://jup.ag)
- [DexScreener](https://dexscreener.com)
- [Solana Official Docs](https://docs.solana.com)

## Support

If you encounter issues:
1. Check Solana documentation
2. Search DuckDuckGo or Google
3. Ask in Solana Discord
4. Check GitHub issues

Good luck with your token! 🚀
