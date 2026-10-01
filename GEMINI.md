# Roblox Script Hub — Workspace Brain

ไฟล์นี้ Agent อ่านอัตโนมัติทุก Session — เขียนสิ่งที่อยากให้จำถาวรไว้ที่นี่

---

## Project Context

- **Project**: 2K Script Hub — Roblox Exploit Scripts
- **Primary Executor**: **Real** (มี Built-in Real MCP Server รองรับการควบคุมเกม/ดีคอมไพล์/ยิง Remote/สแกน Memory โดยตรง)
- **Secondary Targets**: Synapse X, KRNL, Delta, Solara-compatible
- **Style**: Cyber-Neon Obsidian UI หรือ Fluent UI (Theme Aqua, DarkMode, Acrylic)
- **Output**: Single-file `.luau` — Self-contained, run ทันทีผ่าน Executor

---

## กฎที่ต้องจำทุก Session

1. **สคริปต์ต้อง Single-File** — ไม่พึ่งไฟล์แยก รันผ่าน Executor ได้เลย
2. **ก่อนสร้าง UI ใหม่ต้อง Teardown ก่อนเสมอ** — Destroy CoreGui + PlayerGui + Disconnect events
3. **HTTP Bridge ต้องอยู่ใน `task.spawn`** — ห้าม Blocking Thread หลัก
4. **ตรวจสอบก่อน FireServer ทุกครั้ง** — Coins / Cooldown / Distance
5. **ทดสอบผ่าน Real MCP (`real`) เสมอ** — ใช้ `execute`, `get-data-by-code`, `remote-spy`, `gc-scan`, `get-script-content`

---

## Knowledge Files (อ่านเพิ่มเติม)

- [Real MCP Guide](.agents/skills/roblox-scripting/references/real-mcp.md) — คู่มือ Tools ทั้งหมดของ Real Executor (Memory, Decompile, Remotes, Input)
- [Discovered Patterns](.agents/skills/roblox-scripting/references/discovered-patterns.md) — Pattern สะสมจากทุก Session
- [Blade Ball](.agents/skills/roblox-scripting/references/games/blade-ball.md) — Remote, Anti-Cheat, Features
- [WarzPVP](.agents/skills/roblox-scripting/references/games/warzone-pvp.md) — Remote, Anti-Cheat, Features
- [UI Template](.agents/skills/roblox-scripting/references/ui-template.luau) — Cyber-Neon UI เต็มรูปแบบ (สำหรับ In-game 2K Script)

---

## เกมที่กำลังทำ / Queue

| เกม | สถานะ | ไฟล์ |
|-----|-------|------|
| Blade Ball | ✅ v3.0 Done | `TwoK_BladeBall_Hub_v3.luau` |
| WarzPVP | 🔄 In Progress | `WarZPVP.luau` |
| Ride a Pet | ⏳ Queue | `RideAPet.luau` |
| Loot to Forge | ⏳ Queue | `LootToForge.luau` |
| OpenSea Hub | ⏳ Queue | `OpenSeaHub.luau` |

---

## Tools & Reversing Utilities

- **[Dumper (vita8it)](tools/Dumper/main.luau)**: ตัวดึงโครงสร้างเกม Roblox (Instance Explorer, Local/Module Scripts, Sources, Service dump)
  - คำสั่งรันผ่าน Executor:
    ```luau
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vita8it/Dumper/main/main.luau"))()
    ```
  - Output จะบันทึกลงในโฟลเดอร์ executor: `DUMPER-<GUID>/`
- **Roblox Executor MCP (Upstream GitLab)**: `https://gitlab.com/upio/roblox-executor-mcp`
  - Dashboard Web UI: `http://localhost:16384/`
  - Git Upstream: `upstream https://gitlab.com/upio/roblox-executor-mcp.git`
  - Connector: [`connector.luau`](connector.luau) / [`loader.luau`](loader.luau)

---

## 📚 LLM Wiki Architecture (Andrej Karpathy Pattern)

Workspace นี้ใช้ระบบความจำ **LLM Wiki** ตามแนวคิดของ Andrej Karpathy:
- **[Catalog (index.md)](wiki/index.md)**: สารบัญความรู้ทั้งหมดในระบบ
- **[Timeline Log (log.md)](wiki/log.md)**: ประวัติการ Ingest และค้นพบความรู้ใหม่แบบเรียงตามเวลา
- **[3D Web Visualizer](http://localhost:8080/3D_Knowledge_Graph.html)**: Interactive Graph View 3D

### Wiki Operations:
1. **Ingest**: เมื่อผู้ใช้นำ Source, สคริปต์, หรือความรู้ใหม่เข้ามา → อ่านและสกัดประเด็น → อัปเดตหน้า Concept / Game ที่เกี่ยวข้อง → อัปเดต `index.md` → บันทึกลง `log.md` → ซิงค์ขึ้น 3D Graph
2. **Query**: เมื่อตอบคำถามเชิงลึก → ค้นหาจาก `wiki/index.md` และเอกสารที่เกี่ยวข้อง → สังเคราะห์คำตอบ → หากพบคำตอบหรือการเชื่อมโยงที่มีคุณค่า ให้นำกลับมาเขียนเป็นหน้า Wiki ใหม่ทันที
3. **Lint**: ตรวจสอบความถูกต้องของ Wiki สม่ำเสมอ ลบข้อมูลที่ขัดแย้ง และตรวจหา Broken Links



