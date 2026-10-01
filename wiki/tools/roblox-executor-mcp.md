# Roblox Executor MCP (Upstream GitLab)

- **Repository**: `https://gitlab.com/upio/roblox-executor-mcp`
- **GitHub Mirror**: `https://github.com/notpoiu/roblox-executor-mcp`
- **Local Dashboard**: `http://localhost:16384/`
- **Default Port**: `16384`

---

## 1. Overview

Roblox Executor MCP เป็น MCP Server มาตรฐานสำหรับเชื่อมต่อระหว่าง AI Coding Agent กับตัวเกม Roblox ที่กำลังรันอยู่ผ่าน Executor

### ความสามารถหลัก:
- **Code Execution**: รันโค้ด Luau และรับค่า return/print ผ่าน HTTP/WebSocket Bridge
- **Script Inspection**: ดึงซอร์สโค้ดของสคริปต์ในเกม และค้นหาข้อความข้ามทุกไฟล์
- **Instance Search**: ค้นหา Hierarchy Tree ด้วย CSS-like selectors (`QueryDescendants`)
- **Remote Spy**: ดักฟัง, บล็อก, และบันทึกคำสั่ง `FireServer` / `InvokeServer` (สร้างบน [Cobalt](https://github.com/notpoiu/cobalt))
- **GUI Automation**: สั่งคลิกปุ่มบนหน้าจอ และพิมพ์ข้อความลง TextBox
- **Multi-Client Support**: รองรับการต่อ Roblox หลายจอพร้อมกันโดยใช้ `clientId`

---

## 2. In-Game Connector Loop

```luau
while not getgenv().MCP_Loaded do
    local bridgeUrl = getgenv().BridgeURL or "127.0.0.1:16384"
    pcall(function() loadstring(game:HttpGet("http://" .. bridgeUrl .. "/script.luau"))() end)
    task.wait(0.15)
end
```

### การตั้งค่า Global Flags (กำหนดก่อน loadstring):
```luau
getgenv().BridgeURL = "127.0.0.1:16384"                  -- แนะนำใช้ 127.0.0.1 บน Windows
getgenv().DisableWebSocket = true                        -- บังคับใช้ HTTP Polling
getgenv().DisableInitialScriptDecompMapping = true       -- ข้าม decompile สคริปต์ตอนเริ่มเพื่อประหยัด RAM
getgenv().MCP_FailedScriptResyncInterval = 30            -- หน่วงเวลาลองดึงสคริปต์ที่ล้มเหลวซ้ำ
getgenv().MCP_FailedScriptResyncBatchSize = 8            -- จำนวนสคริปต์ต่อรอบการ retry
```
