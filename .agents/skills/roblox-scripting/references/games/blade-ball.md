# Blade Ball — Game Knowledge

**Place ID**: (ใส่เมื่อทราบ)
**Script File**: [`TwoK_BladeBall_Hub_v3.luau`](../../../../../../TwoK_BladeBall_Hub_v3.luau)
**เวอร์ชันล่าสุด**: v3.0

---

## Remote Structure

| Remote Name | Type | Path | Args | หมายเหตุ |
|-------------|------|------|------|----------|
| _ยังไม่ได้ Spy_ | | | | |

---

## Anti-Cheat Analysis

- **Kick Method**: Client-side `lp:Kick()` — bypass ได้ด้วย `hookmetamethod __namecall`
- **Idle Detection**: Standard Roblox `Idled` event — bypass ด้วย VirtualUser
- **Speed Check**: ยังไม่ได้วิเคราะห์

---

## Game Mechanics

- **Ball Physics**: ลูกบอลมี `BasePart` + `BodyVelocity` / `LinearVelocity` — ต้องดัก Part Name
- **Parry Window**: ยังไม่ได้วัด ping-adjusted window
- **Combo System**: ยังไม่ได้วิเคราะห์

---

## Auto Parry Implementation (Current)

```luau
-- วิธีปัจจุบัน: Poll ใน Heartbeat หา Part ชื่อ "Blade" / "Ball" แล้วคำนวณ ToImpact
local function timeToImpact(projPos, projVel, playerPos)
    local dist = (projPos - playerPos).Magnitude
    local speed = projVel.Magnitude
    if speed <= 0.1 then return math.huge end
    local dot = projVel.Unit:Dot((playerPos - projPos).Unit)
    return dot > 0.5 and (dist / speed) or math.huge
end
```

**ปัญหาที่พบ**: ยังไม่มี ping compensation, false positive เมื่อบอลเคลื่อนที่ออกห่าง

---

## Features ที่ทำไปแล้ว

- [x] Auto Parry (Heartbeat-based)
- [x] Anti-Kick (hookmetamethod)
- [x] Anti-AFK (VirtualUser)
- [x] Infinite Jump
- [x] Speed Boost
- [x] Cyber-Neon UI Hub (v3)
- [x] Floating 2K Logo Toggle Button
- [ ] Silent Aim
- [ ] ESP Players
- [ ] Auto Dodge
