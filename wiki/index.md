# LLM Wiki — Knowledge Catalog

> Structured, interlinked personal knowledge base maintained by the AI Assistant based on Andrej Karpathy's LLM Wiki architecture.
> **Last updated**: 2026-10-02

---

## 🛠️ Tools & Infrastructure

| Document | Category | Summary |
|---|---|---|
| [Real MCP](tools/real-mcp.md) | Executor | Primary AI Executor with 60+ tools: decompile in-memory, GC scan, remote spy, hook inspection |
| [Dumper (vita8it)](tools/dumper.md) | Reversing | Full game structure and script extractor (Explorer tree, Remotes, Local/Module scripts) |
| [Roblox Executor MCP](tools/roblox-executor-mcp.md) | Bridge | Upstream GitLab project (`upio/roblox-executor-mcp`) providing the local HTTP/WebSocket bridge and dashboard |

---

## 🧠 Core Concepts & Patterns

| Document | Category | Summary |
|---|---|---|
| [Stealth & Anti-Kick](concepts/stealth-anti-kick.md) | Bypass | Metamethod interception (`__namecall`), `lp.Kicked` disabling, and `VirtualUser` anti-AFK |
| [Non-Blocking Networking](concepts/non-blocking-networking.md) | Networking | Windows IPv6 `localhost` resolution fix, `task.spawn` thread isolation, and circuit breakers |
| [2K Cyber-Neon UI](concepts/ui-cyber-neon.md) | UI/UX | Obsidian/Cyan aesthetic, bold typography, floating button with rotating beam, drag/click separation |
| [Combat & Spatial Math](concepts/combat-math.md) | Combat | Auto-parry trajectory calculation, time-to-impact, dot product direction, and ping offset compensation |
| [Lifecycle & Memory Management](concepts/lifecycle-maid.md) | Architecture | Connection Maid pattern, event teardown, thread cancellation, and preventing ghost loops |

---

## 🎮 Game Knowledge Bases

| Document | Status | Summary |
|---|---|---|
| [Blade Ball](games/blade-ball.md) | ✅ v3.0 | Ball velocity tracking, parry window timing, safe legit parry engine, anti-kick |
| [WarzPVP](games/warz-pvp.md) | 🔄 Active | Warzone PvP reverse engineering, combat hooks, connector stability |
| [Ride a Pet](games/ride-a-pet.md) | ⏳ Queue | Pet mechanics, economy remotes, auto-farm design |
| [Loot to Forge](games/loot-to-forge.md) | ⏳ Queue | Mining/Forging remotes, inventory management |
| [OpenSea Hub](games/opensea-hub.md) | ⏳ Queue | Island exploration, item automation |

---

## 📜 Raw Sources & References

| Source | Type | Summary |
|---|---|---|
| [Karpathy LLM Wiki Gist](sources/karpathy-llm-wiki.md) | Architecture | Original idea document by Andrej Karpathy proposing the persistent LLM Wiki pattern |
| [Real MCP Official Docs](sources/real-mcp-docs.md) | Specification | In-app documentation and tool schemas of Real Executor MCP |
