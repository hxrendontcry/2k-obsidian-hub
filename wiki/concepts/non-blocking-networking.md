# Non-Blocking Networking & IPv6 Resolution Fix

บันทึกการแก้ปัญหาเรื่อง Network Freeze และการสื่อสารกับ Local Bridge Server

---

## 1. ปัญหา Windows IPv6 Loopback Bug

### อาการ
เมื่อสคริปต์ใน Executor เรียกใช้ `game:HttpGet("http://localhost:16384/...")`:
- ตัวเกม Roblox จะหยุดทำงาน (Not Responding / Freeze) นานถึง 20–30 วินาที

### สาเหตุ
- Windows Network Stack พยายาม resolve ชื่อ `localhost` เป็น IPv6 (`::1`) ก่อน
- ถ้า Server ของ Executor รอรับเฉพาะ IPv4 (`127.0.0.1`) การเชื่อมต่อจะค้างจนกว่า DNS Timeout จะทำงาน

### วิธีแก้
- **ระบุ IP ชัดเจน**: ใช้ `127.0.0.1:16384` แทน `localhost:16384`
- **แยก Thread**: ครอบการเชื่อมต่อด้วย `task.spawn` เสมอ เพื่อไม่ให้กระทบ Thread หลักของเอนจินเกม

---

## 2. Safe Asynchronous Bridge Loader Pattern

```luau
task.spawn(function()
    local bridgeHost = getgenv().BridgeURL or "127.0.0.1:16384"
    local maxRetries = 15
    local attempt = 0

    while not getgenv().MCP_Loaded and attempt < maxRetries do
        attempt += 1
        pcall(function()
            local src = game:HttpGet("http://" .. bridgeHost .. "/script.luau?t=" .. os.time())
            if src and #src > 10 then
                loadstring(src)()
            end
        end)
        task.wait(0.5)
    end
end)
```
