# Stealth & Anti-Kick Patterns

เทคนิคการป้องกัน Client-Side Detection และระงับคำสั่งเตะออกจากเกมของผู้เล่นใน Luau

---

## 1. Metamethod Interception (`__namecall`)

ระบบป้องกันการสั่ง `LocalPlayer:Kick()` โดยดักจับที่ระดับ Metatable:

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

    -- ตัดการเชื่อมต่อ Event Kicked
    if getconnections and lp.Kicked then
        for _, c in ipairs(getconnections(lp.Kicked)) do
            if c.Disable then c:Disable() end
        end
    end
end)
```

---

## 2. Anti-AFK Engine

ป้องกันการถูกตัดการเชื่อมต่อเมื่ออยู่นิ่งเกิน 20 นาที (Error Code 268 / 273):

```luau
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)
```

---

## 3. Remote Validation Rule

ก่อนสั่งยิง `FireServer` ให้ตรวจสอบเงื่อนไขที่จำเป็นเสมอ:
- ยอดเงิน / ทรัพยากร (Coins, Gold)
- คูลดาวน์ (Cooldown timestamp)
- ระยะทางระหว่างตัวละครกับเป้าหมาย (Distance check)
