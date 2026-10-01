# Real MCP — Complete Toolset & Architecture Reference

เอกสารอ้างอิงสำหรับ **Real** (Roblox Executor with built-in MCP Server) ที่ใช้งานร่วมกับ AI Assistant

---

## 1. Connection & Endpoints

- **Server Type**: Local MCP Server (Stdio Relay / Local HTTP)
- **Stdio Relay Executable**:
  ```
  C:\Users\098ko\AppData\Local\Real\data\mcp\real-mcp.exe
  ```
  *(Relay จะ resolve live endpoint เองอัตโนมัติแม้ Real มีการ restart/update)*
- **HTTP Endpoint**:
  ```
  http://127.0.0.1:3872/mcp
  ```
  - Authorization: `Bearer 078cf8587d2790a2cd39eac89ef796fd766ba2a2bca92dc1e48aa82d286d0d89`

---

## 2. หมวดหมู่ Tools และฟังก์ชันการทำงาน

### 2.1 API & Pre-flight Inspection (ไม่ต้อง Inject Client ก็ใช้งานได้)
- `search-api`: ค้นหา Global functions, Libraries, Signatures, Docs และ Quirks ของ Real Executor ก่อนลงมือเขียนโค้ด Luau
- `launch-roblox`: สั่งเปิด Roblox เวอร์ชั่นที่ Real ซัพพอร์ต
- `open-script`: บันทึกสคริปต์ลงโฟลเดอร์ `Scripts/MCP` และเปิดขึ้นเป็นแท็บใน Real Editor
- `check-script`: ทำ Luau Linting และ Type-checking ก่อนรันหรือบันทึก

### 2.2 Client Management & Injection
- `list-clients`: ลิสต์เกมและ Roblox Client ที่กำลังทำงานอยู่
- `set-active-client`: เลือก Client เป้าหมายที่จะส่งคำสั่ง
- `inject`: สั่ง Inject Real เข้าสู่ Roblox Client

### 2.3 Code Execution
- `get-data-by-code`: รันโค้ด Luau แล้วดึงค่าที่ `return` หรือ `print` ออกมาเป็น Table/Data
- `eval`: ประเมินค่า Single Luau Expression แบบด่วน
- `execute` / `execute-file`: รันสคริปต์แบบ Fire-and-forget (เหมาะสำหรับ Auto Farm / Loop ยาว)
- `live-reload`: รันสคริปต์ใหม่โดยไม่สร้าง instance ซ้อน (ล้าง listeners เดิมออก แต่อุ้มค่าในตาราง `STATE` ไว้)

### 2.4 Instance & Game World Inspection
- `search-instances`: ค้นหา Object ด้วย `QueryDescendants` selector (เร็วกว่า GetDescendants)
- `get-descendants-tree`: ดึงโครงสร้าง Tree ย่อส่วน
- `get-game-info`: สรุปข้อมูล Place ID, Game Name, สภาพแวดล้อม
- `get-nil-instances`: ดู Instances ที่หลุดไปอยู่ใน `nil` (Parent = nil)
- `get-instance-properties`: ดึง Properties, Attributes, Tags ทั้งหมด (รวม Hidden Properties)
- `get-tagged`: ค้นหา Instance ตาม CollectionService Tag
- `get-property`: อ่านค่า Property รายตัว
- `list-players`: ดูข้อมูลผู้เล่นในเซิร์ฟเวอร์ (ทีม, เลือด, ตำแหน่ง Position)

### 2.5 Automation (กระทำกับเกมโดยไม่ต้องเขียน Luau Script)
- `fire-remote`: ยิง RemoteEvent หรือ RemoteFunction โดยตรงผ่าน Path
- `set-property`: เปลี่ยนค่า Property ของ Instance โดยตรง
- `call-method`: เรียกใช้งาน Method ของ Instance โดยตรง

### 2.6 Memory & Garbage Collector (GC)
- `gc-scan`: ฟิลเตอร์ `getgc()` หา Table หรือ Function โดยจับคู่ Key, Value, Constant หรือ Upvalue
- `get-env`: ดึงตาราง Environment (`getgenv`, `getrenv`, `getreg`)

### 2.7 Script Decompiling & Indexing (การแกะโค้ดเกม)
- `get-script-content`: สั่ง Decompile LocalScript / ModuleScript แบบ Native
- `script-grep`: ค้นหาข้อความ/Regex ใน Decompiled Sources ทั้งหมด
- `get-script-strings`: ดึง String Literals ตรงจาก Bytecode (สำหรับสคริปต์ที่ติด Decompile Error)
- `build-script-index`: สั่ง Decompile ทั้งเกม 1 ครั้งเก็บใน RAM เพื่อให้ `script-grep` ค้นหาได้ทันที
- `find-remote-callers`: ค้นหาว่า Remote ถูกเรียก/ยิงจากสคริปต์ไหน บรรทัดไหน
- `search-scripts`: ค้นหาสคริปต์ตามความหมาย (Semantic Search เช่น *"where are purchases handled"*)

### 2.8 Remote Spy & Network Interception
- `remote-spy`: ดูประวัติการยิง Remote, บล็อก (Block) หรือเพิกเฉย (Ignore) คำสั่ง `FireServer` / `InvokeServer`

### 2.9 Input & UI Inspection
- `send-input`: จำลอง Real Keyboard & Mouse (Key press, Clicks, Absolute/Relative moves, Scroll)
- `type-text-box`: สั่งพิมพ์ข้อความลงใน TextBox
- `click-button`: สั่งคลิก GuiButton ในจอ
- `dump-visible-ui`: ดึง UI ทุกตัวที่ผู้เล่นมองเห็นอยู่ ณ ปัจจุบันพร้อม Path ที่สามารถกระทำได้
- `screenshot-window`: จับภาพหน้าต่างเกมเป็นไฟล์ PNG
- `list-roblox-windows`: ดูรายการหน้าต่าง Roblox ที่เปิดอยู่

### 2.10 Runtime & Anti-Cheat Hooks Analysis
- `list-connections`: ดู Closure Functions ที่ผูกอยู่กับ Signal ต่างๆ
- `dump-anticheat-hooks`: ตรวจดูว่า DataModel Metatable ถูก Hook ไว้ตรงไหนบ้าง
- `list-special-instances`: สแกนหา Nil-parented objects, Running scripts, Actors
- `spy-closure`: Hook ดักฟัง Function ที่กำลังทำงานอยู่และบันทึก Arguments ที่ถูกส่งเข้ามา

### 2.11 Game Knowledge & Long-Term Memory
- `remember-game`: บันทึกข้อมูลที่วิเคราะห์ได้ของเกมนั้นๆ ลงใน Memory ของ Real
- `recall-game-memory`: ดึงข้อมูลที่เคยบันทึกไว้ในอดีตของเกมนี้กลับมา
- `forget-game-memory`: ลบความจำของเกม
- `game-feedback`: ส่ง Feedback การทำงานกลับเข้า Memory
