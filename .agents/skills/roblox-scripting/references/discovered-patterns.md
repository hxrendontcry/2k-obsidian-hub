# Discovered Patterns & Session Findings

ไฟล์นี้เก็บ Pattern, Bug, Solution ที่ค้นพบระหว่างทำงานแต่ละ Session
Agent จะ append ข้อมูลใหม่ที่นี่ทุกครั้งที่ค้นพบสิ่งสำคัญ

---

## Network & Bridge

| วันที่ | เกม | สิ่งที่ค้นพบ |
|--------|-----|-------------|
| 2026-10-01 | WarzPVP | `localhost` ทำให้เกมค้างบน Windows เพราะ IPv6 DNS timeout — ต้องใช้ `127.0.0.1` หรือครอบ `task.spawn` |
| 2026-10-01 | WarzPVP | `while not getgenv().MCP_Loaded do` แบบ Blocking ใน Thread หลักทำให้ Roblox Not Responding |

---

## UI & Rendering

| วันที่ | เกม | สิ่งที่ค้นพบ |
|--------|-----|-------------|
| 2026-09-30 | BladeBall | Floating Button ต้องแยก Drag กับ Click ด้วย `(pos - start).Magnitude < 6` ไม่งั้นหน้าต่างเด้งปิดตอนลาก |
| 2026-09-30 | BladeBall | `getsynasset` / `getcustomasset` ต้องใช้แบบ fallback chain เพราะ Executor แต่ละตัว API ต่างกัน |

---

## Anti-Cheat & Bypass

| วันที่ | เกม | สิ่งที่ค้นพบ |
|--------|-----|-------------|
| | | _เพิ่มเมื่อค้นพบ_ |

---

## Remote Structure

| วันที่ | เกม | Remote Name | วิธีใช้ |
|--------|-----|-------------|---------|
| | | | _เพิ่มเมื่อ Remote Spy_ |

---

## Performance

| วันที่ | เกม | สิ่งที่ค้นพบ |
|--------|-----|-------------|
| | | _เพิ่มเมื่อค้นพบ_ |
