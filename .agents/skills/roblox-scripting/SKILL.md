---
name: roblox-scripting
description: Workflow and architectural guidelines for authoring Roblox exploit/hack scripts (Luau) — 2K Script Cyber-Neon UI hubs, Fluent UI, stealth anti-kick/bypass, Auto Farm, Auto Parry, remote manipulation, and executor script architecture.
---

# Roblox Scripting Skill ("2K Script" Architecture)

สกิลสำหรับการเขียนสคริปต์โปร Roblox (Luau) — UI Hub, Stealth, Auto Farm, Combat Engine, Remote Manipulation

---

## 1. กฎหลัก

1. **Single-File, Ready to Execute** — เขียนลงไฟล์ `.luau` ของเกมนั้นๆ เสมอ (เช่น `WarZPVP.luau`, `TwoK_BladeBall_Hub_v3.luau`) เป็น Self-Contained รันผ่าน Executor ได้ทันที

2. **UI Teardown ก่อนสร้างใหม่** — ก่อนสร้าง UI ให้ `:Destroy()` instance เก่าใน `CoreGui` และ `PlayerGui` ป้องกัน Ghost UI และ Memory Leak

3. **Remote Validation ก่อน FireServer** — ตรวจสอบเงิน / Cooldown / ระยะห่าง ก่อน `FireServer` หรือ `InvokeServer` เพื่อลด Anti-Cheat Flag และ Error Spam

4. **Non-blocking Loops** — ห้ามรัน loop แบบ Blocking ใน Thread หลัก ต้องครอบด้วย `task.spawn` เสมอ

---

## 2. Stealth & Anti-Kick (วางบรรทัดแรกของสคริปต์)

```luau
pcall(function()
    local lp = game:GetService("Players").LocalPlayer
    local orig_nc
    orig_nc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" and self == lp then
            warn("[2K SCRIPT] Kick suppressed")
            return nil
        end
        return orig_nc(self, ...)
    end))
    if getconnections and lp.Kicked then
        for _, c in ipairs(getconnections(lp.Kicked)) do
            if c.Disable then c:Disable() end
        end
    end
end)

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)
```

---

## 3. UI Architecture: 2K Cyber-Neon Obsidian

- **Palette**: Navy `Color3.fromRGB(10, 14, 25)` · Cyan `Color3.fromRGB(0, 235, 255)` · Blue `Color3.fromRGB(0, 130, 255)`
- **Font**: `Enum.Font.GothamBold` สองภาษา — หัวข้อไทย + ซับ EN ตัวพิมพ์ใหญ่
- **Zero Emojis**: ใช้ Asset ID (`rbxassetid://...`) แทน 100%
- **Floating Toggle Button**: วงกลมลอยน้ำ + ขอบแสงหมุน `UIStroke` + `UIGradient` ด้วย `TweenService`
- **Drag vs Click Separation**: `(currentPos - clickStart).Magnitude < 6` px — ไม่ให้หน้าต่างเด้งปิดตอนลาก
- **ทางเลือก Fluent UI**: Theme `"Aqua"`, DarkMode, Acrylic, ชื่อ `"2K Script"`
- เทมเพลตโค้ดเต็ม: [references/ui-template.luau](references/ui-template.luau)

---

## 4. Auto Farm & Loop Pattern

```luau
local running = false

local function setAutoFarm(enabled)
    running = enabled
    if not running then return end
    task.spawn(function()
        while running do
            -- logic ที่เช็คเงื่อนไขแล้ว
            task.wait(0.2)
        end
    end)
end
```

---

## 5. Combat Engine (Auto Parry / Aimbot Math)

```luau
-- คำนวณเวลาก่อนกระสุน/ลูกบอลถึงตัวผู้เล่น
local function timeToImpact(projPos, projVel, playerPos)
    local dist = (projPos - playerPos).Magnitude
    local speed = projVel.Magnitude
    if speed <= 0.1 then return math.huge end
    local dot = projVel.Unit:Dot((playerPos - projPos).Unit)
    return dot > 0.5 and (dist / speed) or math.huge
end
```

---

## 6. Remote Manipulation Pattern

```luau
-- ตรวจสอบก่อนยิง Remote เสมอ
local function safeFire(remoteName, ...)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName, true)
    if not remote then return end

    local lp = game:GetService("Players").LocalPlayer
    local stats = lp:FindFirstChild("leaderstats")
    -- ใส่เงื่อนไขที่เหมาะสมกับเกมนั้น เช่น stats.Coins.Value >= cost
    pcall(function()
        remote:FireServer(...)
    end)
end
```

---

## References
- [wiki/index.md](../../wiki/index.md) — **LLM Wiki Catalog**: สารบัญความรู้แบบ Persistent ตามแนวคิด Andrej Karpathy
- [wiki/log.md](../../wiki/log.md) — **LLM Wiki Timeline Log**: ประวัติการ Ingest และค้นพบความรู้ใหม่
- [references/real-mcp.md](references/real-mcp.md) — **Real MCP Guide**: สารบัญคำสั่งและเครื่องมือของ Real Executor (Decompile, Memory, Remotes, Input)
- [references/ui-template.luau](references/ui-template.luau) — เทมเพลต UI Cyber-Neon เต็มรูปแบบ (ScreenGui, Floating Button, Tabs, Toggles)
- [references/game-automation.md](references/game-automation.md) — Connection Maid, Remote Validation, Combat Math
- [references/dumper-tool.md](references/dumper-tool.md) — Dumper (vita8it): สคริปต์ดูดโครงสร้างแมพ, Remotes, และ Client/Module Scripts
- [references/discovered-patterns.md](references/discovered-patterns.md) — **Pattern & Bug สะสมจากทุก Session** (อ่านก่อนทำงานเสมอ)

### Game-Specific Knowledge
- [references/games/blade-ball.md](references/games/blade-ball.md) — Blade Ball: Remote, Anti-Cheat, Auto Parry, Features
- [references/games/warzone-pvp.md](references/games/warzone-pvp.md) — WarzPVP: Remote, Anti-Cheat, Known Issues

> **กฎ**: เมื่อค้นพบ Remote ใหม่, Anti-Cheat method, หรือ Bug Fix — ให้อัปเดตลง `wiki/` และ append ลง `wiki/log.md` ทันที


