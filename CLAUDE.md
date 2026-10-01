# 2K Script Hub & Knowledge Core — Claude Code Instructions

This file is automatically loaded by Claude Code (Claude CLI) when working in this directory.

---

## 🧠 LLM Wiki & Knowledge Navigation (Karpathy Pattern)

This workspace follows the **LLM Wiki** pattern:
- **[Catalog](wiki/index.md)** (`wiki/index.md`): Master catalog of all concepts, tools, and game reversing intel.
- **[Timeline Log](wiki/log.md)** (`wiki/log.md`): Chronological log of discoveries, ingests, and architectural refactors.
- **[3D Visualizer](3D_Knowledge_Graph.html)**: Live 3D Obsidian Stealth graph view (`http://localhost:8080/3D_Knowledge_Graph.html`).
- **Always consult `wiki/index.md`** before implementing new features or reversing new games.

---

## 🛠️ Primary Skill: Roblox Scripting

The project's architectural guidelines and core patterns are documented in:
👉 **`.agents/skills/roblox-scripting/SKILL.md`**

Key principles to follow for every script:
1. **Single-File Output**: Always self-contained `.luau` files ready to run via executor.
2. **UI Teardown Support**: Clean up previous `CoreGui` and `PlayerGui` instances, disconnect event connections, and cancel loops before instantiating new UI.
3. **Non-blocking Networking**: Always wrap HTTP requests or heavy loops in `task.spawn`.
4. **Remote Validation**: Validate costs, cooldowns, and distances before calling `FireServer` or `InvokeServer`.

---

## 🔌 MCP Integration (Real MCP)

- **Primary Executor**: **Real** (MCP Server on port `3872` or stdio relay).
- **Relay Executable**: `C:\Users\098ko\AppData\Local\Real\data\mcp\real-mcp.exe`
- **HTTP Endpoint**: `http://127.0.0.1:3872/mcp`
- Complete tool reference: [`wiki/tools/real-mcp.md`](wiki/tools/real-mcp.md)

---

## 📁 Key File References

- UI Template (Cyber-Neon): [`.agents/skills/roblox-scripting/references/ui-template.luau`](.agents/skills/roblox-scripting/references/ui-template.luau)
- Real MCP Reference: [`.agents/skills/roblox-scripting/references/real-mcp.md`](.agents/skills/roblox-scripting/references/real-mcp.md)
- Game Intel (Blade Ball): [`.agents/skills/roblox-scripting/references/games/blade-ball.md`](.agents/skills/roblox-scripting/references/games/blade-ball.md)
- Game Intel (WarzPVP): [`.agents/skills/roblox-scripting/references/games/warzone-pvp.md`](.agents/skills/roblox-scripting/references/games/warzone-pvp.md)
