# LLM Wiki — Chronological Log

> Append-only timeline of knowledge base ingests, discoveries, refactors, and lint passes.
> Format: `## [YYYY-MM-DD] <operation> | <title>`

---

## [2026-10-02] init | Initialize LLM Wiki Architecture
- Implemented Andrej Karpathy's LLM Wiki pattern ([Gist 442a6bf555914893e9891c11519de94f](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)).
- Created three-tier architecture: Raw Sources, The Wiki, The Schema (`GEMINI.md`).
- Structured `wiki/index.md` (catalog) and `wiki/log.md` (timeline).
- Linked with 3D Knowledge Graph Web UI (`3D_Knowledge_Graph.html` on port 8080).

## [2026-10-02] ingest | Real MCP Executor Documentation
- Ingested official docs and tool capabilities from in-app screenshots.
- Extracted relay executable path (`C:\Users\098ko\AppData\Local\Real\data\mcp\real-mcp.exe`).
- Verified that `real` MCP server is active in Antigravity with 60+ tools.
- Created `wiki/tools/real-mcp.md` and added to 3D graph as hub node (32pt).

## [2026-10-02] ingest | Dumper Tool by vita8it
- Cloned repository `https://github.com/vita8it/Dumper` to `tools/Dumper/`.
- Documented usage: `loadstring(game:HttpGet("https://raw.githubusercontent.com/vita8it/Dumper/main/main.luau"))()`.
- Analyzed dump outputs: `Explorer`, `Agent`, `Scripts` (LocalScript/ModuleScript), and `Sources`.
- Created `wiki/tools/dumper.md` and added to 3D graph.

## [2026-10-02] ingest | Roblox Executor MCP Upstream GitLab
- Ingested upstream repository: `https://gitlab.com/upio/roblox-executor-mcp`.
- Configured git remote `upstream https://gitlab.com/upio/roblox-executor-mcp.git`.
- Documented local web dashboard at `http://localhost:16384/`.
- Created `wiki/tools/roblox-executor-mcp.md`.

## [2026-10-01] discovery | Windows IPv6 Loopback Hang in WarzPVP
- Diagnosed game freezing caused by `localhost` resolving to IPv6 `::1` before timing out (20-30s).
- Solved by mandating IPv4 `127.0.0.1` and wrapping loader in `task.spawn` with retry limits.
## [2026-10-02] feature | Real MCP Live Web HUD & Polling in 3D Visualizer
- Integrated Real-time MCP Bridge polling into `3D_Knowledge_Graph.html` (polls `/api/status` every 2.5s).
- Added live status badge on the top navigation bar (Emerald pulsing when game connected, Amber when listening, Rose if offline).
- Added interactive Monitor Modal showing active injected clients, role, port, and quick connector copy button.
- Dynamically highlights `real-mcp` and `mcp-executor` nodes in the 3D scene with emerald neon glow upon client connection.

## [2026-10-02] refactor | Cyberpunk Obsidian Stealth Web UI (Style 3)
- Overhauled 3D Knowledge Graph Web UI (`3D_Knowledge_Graph.html`) to Style 3: Cyberpunk Obsidian Stealth.
- Structure: Smoke Glass (`rgba(7, 8, 12, 0.84)`, 24px blur) with ultra-thin 1px titanium borders (`rgba(255, 255, 255, 0.08)`).
- Lighting & Color: Monochrome Black-Gray-White palette (Platinum, Graphite Slate, Titanium, Silver, Carbon, White) with high-intensity laser highlight (`#00ff88`) reserved strictly for telemetry triggers and target locks.

## [2026-10-02] release | WarzPVP Master Hub v3.0 Complete
- Reverse engineered WarzPVP PlaceId `135187059974536`, Universe `10763998990`.
- Extracted and hooked remotes: `ConfirmRespawn`, `PickupLoot`, `UseItem`, `BuyItem`, `CombineMags`, `BagAllToStash`, `JoinMap`, `ReloadRequest`.
- Reverse-engineered `WarzSpread` math engine, implementing zero spread hook on `CalcSpread` and `ApplySpread`.
- Built safe Hitbox Expander, No Recoil, Fast Reload, and Auto-Heal engine.
- Implemented dual-layer ESP: Full Player ESP (3D Highlight, Name, Distance, HP bar, Tracers) + Loot ESP (color-coded item rarity tags).
- Reverse engineered all 12 official game map coordinates from `ReplicatedStorage.Shared.Config.MapCatalog` into Tactical Teleport module.
- Applied Stealth Kick Interceptor via `__namecall` metamethod.

