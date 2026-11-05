# Etsy Manager

A Claude Code agent (`.claude/agents/etsy-manager.md`) that helps run an Etsy shop: listing SEO, pricing with fees, buyer replies, stats reviews, ads, policy compliance and seasonal planning.

## Use
1. Fill in `shop-profile.md`.
2. Export CSVs from Etsy Shop Manager (Settings > Options > Download Data) into `data/`.
3. Open a Claude Code session on this repo and ask, e.g. "Use etsy-manager to review last month's sales".

Listing drafts are saved to `listings/`, reports to `reports/`. With the Etsy connector authorized (AnythingMCP), the agent can read the shop and create draft listings (always with your approval). Keep this repo **private** — it contains sales data.
