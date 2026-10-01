# Dumper Tool (by vita8it) — Game Reversing & Structure Extraction

เครื่องมือ Dump โครงสร้าง Instance, Services, และ Scripts ทั้งหมดของแมพ Roblox ลงไฟล์ดิสก์ของ Executor เพื่อนำมาวิเคราะห์ Remotes, Game Logic, และหาช่องโหว่

---

## 1. วิธีการรันใน Executor

รันผ่านคำสั่ง `loadstring` ดึงจาก GitHub ได้โดยตรง:

```luau
-- รัน Dumper ตัวเต็ม
loadstring(game:HttpGet("https://raw.githubusercontent.com/vita8it/Dumper/main/main.luau"))()
```

หรือถ้ารันจากไฟล์ Local ที่โคลนไว้ในโปรเจกต์ ([`tools/Dumper/main.luau`](../../../../tools/Dumper/main.luau)):

```luau
-- ตัวอย่างรันแบบ Local (หาก Executor รองรับ readfile)
loadstring(readfile("Dumper/main.luau"))()
```

---

## 2. สิ่งที่เครื่องมือจะ Dump ออกมา

ไฟล์ผลลัพธ์จะถูกบันทึกไว้ในโฟลเดอร์ของ Executor: `workspace/DUMPER-<GUID>/`

1. **`Explorer.json` / `Explorer.txt`**:
   - ลิสต์โครงสร้าง Tree ของ Services สำคัญ:
     - `Players.LocalPlayer`
     - `ReplicatedStorage` (Remotes, Shared Modules, Assets)
     - `ReplicatedFirst` (Client Init Scripts, Anti-Cheat Loaders)
     - `SoundService`
     - `Workspace`
     - `Lighting`
     - `Teams`
2. **`Agent/`**:
   - ข้อมูล ClassNames, Properties, Metadata ของแต่ละ Instance
3. **`Scripts/`**:
   - ซอร์สโค้ดของ `LocalScript` และ `ModuleScript` ทั้งหมดที่ Client สามารถเข้าถึงและดึง source ออกมาได้
4. **`Sources/`**:
   - Bytecode / Decompiled sources

---

## 3. ประโยชน์ในการพัฒนา 2K Script Hub

- **หา Remote ทั้งหมดในแมพ**: เจาะดู `ReplicatedStorage` เพื่อดูชื่อและตำแหน่งของ RemoteEvents / RemoteFunctions ทั้งหมด
- **แกะ Anti-Cheat ของเกม**: อ่านโค้ดใน `ReplicatedFirst` และ `PlayerScripts` เพื่อดูว่าเกมตรวจจับ WalkSpeed, JumpPower, Teleport หรือ Hooking แบบไหน
- **จำลอง Game Data**: ดึงค่า Item IDs, Crafting Recipes, Weapon Stats จาก ModuleScripts ในเกม
