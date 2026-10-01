# Roblox Game Automation & Combat Engine Patterns

คู่มือการออกแบบตรรกะเบื้องหลังสำหรับสคริปต์ Roblox (Game Automation, Combat Engine, Anti-Detection และ State Management)

---

## 1. Lifecycle & Connection Management (การป้องกัน Memory Leaks)

เมื่อผู้ใช้ปิดหน้าต่าง UI หรือรันสคริปต์ซ้ำ หากไม่ Disconnect Event เก่า ตัวเกมจะเกิด Memory Leak, FPS ดรอป และเกิดอาการรันซ้ำซ้อน (Ghost Loop)

### Maid / Connection Manager Pattern
```luau
local ConnectionManager = {
    _connections = {},
    _threads = {},
    _instances = {}
}

function ConnectionManager:Add(conn)
    table.insert(self._connections, conn)
    return conn
end

function ConnectionManager:Spawn(fn)
    local thread = task.spawn(fn)
    table.insert(self._threads, thread)
    return thread
end

function ConnectionManager:RegisterInstance(inst)
    table.insert(self._instances, inst)
    return inst
end

function ConnectionManager:Cleanup()
    -- 1. ตัดการเชื่อมต่อ Event ทั้งหมด
    for _, conn in ipairs(self._connections) do
        pcall(function()
            if typeof(conn) == "RBXScriptConnection" and conn.Connected then
                conn:Disconnect()
            end
        end)
    end
    table.clear(self._connections)

    -- 2. ยกเลิก Thread ที่ทำงานอยู่
    for _, th in ipairs(self._threads) do
        pcall(function()
            if typeof(th) == "thread" and coroutine.status(th) ~= "dead" then
                task.cancel(th)
            end
        end)
    end
    table.clear(self._threads)

    -- 3. ลบ UI / Visual Objects ที่สร้างไว้
    for _, inst in ipairs(self._instances) do
        pcall(function()
            if typeof(inst) == "Instance" then
                inst:Destroy()
            end
        end)
    end
    table.clear(self._instances)
end
```

---

## 2. Remote Validation (ตรวจสอบเงื่อนไขก่อนส่ง Remote)

### กฎสำคัญ
ห้ามส่ง `RemoteEvent:FireServer(...)` หรือ `RemoteFunction:InvokeServer(...)` รัวๆ โดยไม่มีการเช็คสถานะของผู้เล่น เพราะจะทำให้โดน Anti-Cheat ตรวจจับหรือเกิด Server Error Spam

### ตัวอย่างการตรวจสอบ
```luau
local function safePurchase(itemId, cost)
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if not leaderstats then return false end

    local coins = leaderstats:FindFirstChild("Coins") or leaderstats:FindFirstChild("Gold")
    if not coins or coins.Value < cost then
        return false -- เงินไม่พอ ไม่ส่ง Remote
    end

    local buyRemote = ReplicatedStorage:FindFirstChild("BuyItem", true)
    if buyRemote and buyRemote:IsA("RemoteEvent") then
        buyRemote:FireServer(itemId)
        return true
    end
    return false
end
```

---

## 3. Stealth Interception & Anti-Kick

ระงับการสั่ง Kick จาก Client-Side Anti-Cheat:

```luau
-- Suppress Kick via __namecall
pcall(function()
    local lp = game:GetService("Players").LocalPlayer
    local orig_nc
    orig_nc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" and self == lp then
            warn("[2K SCRIPT] Client-side Kick intercepted and suppressed!")
            return nil
        end
        return orig_nc(self, ...)
    end))

    -- Disable Kicked Connections if available
    if getconnections and lp.Kicked then
        for _, conn in ipairs(getconnections(lp.Kicked)) do
            if conn.Disable then conn:Disable() end
        end
    end
end)

-- Anti-AFK Engine
pcall(function()
    local vu = game:GetService("VirtualUser")
    local lp = game:GetService("Players").LocalPlayer
    lp.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)
```

---

## 4. Combat Engine & Spatial Math (เช่น Auto Parry / Aimbot)

การคำนวณระยะทาง ความเร็ว และเวลาในการเข้าถึงเป้าหมาย (Time to Impact):

```luau
local function calculateTimeToImpact(projectilePosition, projectileVelocity, playerPosition)
    local distance = (projectilePosition - playerPosition).Magnitude
    local speed = projectileVelocity.Magnitude
    if speed <= 0.1 then return math.huge end

    -- คำนวณทิศทางการเคลื่อนที่ของลูกบอล/กระสุน
    local direction = projectileVelocity.Unit
    local toPlayer = (playerPosition - projectilePosition).Unit
    local dot = direction:Dot(toPlayer)

    -- ถ้า dot > 0 แสดงว่าพุ่งเข้าหาตัวผู้เล่น
    if dot > 0.5 then
        return distance / speed
    end
    return math.huge
end
```
