# Lifecycle & Memory Management (Maid Pattern)

การจัดการ Lifecycle และการป้องกัน Memory Leak ในสคริปต์ Roblox Exploit

---

## 1. ปัญหา Ghost Loops และ Signal Leaks

เมื่อผู้ใช้ปิดหน้าต่าง UI หรือรันสคริปต์ซ้ำซาก:
- `RBXScriptConnection` ที่ยังเปิดค้างไว้จะรันโค้ดซ้ำซ้อน ทำให้ FPS ดรอป
- `thread` ที่รัน `while true do` จะยังคงทำงานในพื้นหลัง (Ghost Worker)

---

## 2. Connection Manager / Maid Class

```luau
local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({
        _connections = {},
        _threads = {},
        _instances = {}
    }, Maid)
end

function Maid:GiveTask(taskItem)
    if typeof(taskItem) == "RBXScriptConnection" then
        table.insert(self._connections, taskItem)
    elseif typeof(taskItem) == "thread" then
        table.insert(self._threads, taskItem)
    elseif typeof(taskItem) == "Instance" then
        table.insert(self._instances, taskItem)
    end
    return taskItem
end

function Maid:DoCleaning()
    for _, c in ipairs(self._connections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(self._connections)

    for _, th in ipairs(self._threads) do
        pcall(function() task.cancel(th) end)
    end
    table.clear(self._threads)

    for _, inst in ipairs(self._instances) do
        pcall(function() inst:Destroy() end)
    end
    table.clear(self._instances)
end

return Maid
```
