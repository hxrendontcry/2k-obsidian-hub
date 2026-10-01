# 2K Cyber-Neon UI Architecture

สถาปัตยกรรม UI สไตล์ Cyber-Neon Obsidian สำหรับ Roblox Script Hubs

---

## 1. Design Token Palette

```luau
local THEME = {
    MainBg       = Color3.fromRGB(10, 14, 25),    -- Obsidian Deep Navy
    SidebarBg    = Color3.fromRGB(12, 17, 30),    -- Midnight Sidebar
    CardBg       = Color3.fromRGB(16, 23, 40),    -- High-contrast Card
    CardStroke   = Color3.fromRGB(0, 170, 255),   -- Vivid Electric Stroke
    RowBg        = Color3.fromRGB(13, 19, 34),    -- Dark Row
    RowStroke    = Color3.fromRGB(0, 130, 220),   -- Row Border
    NeonCyan     = Color3.fromRGB(0, 235, 255),   -- Glowing Cyan Accent
    NeonBlue     = Color3.fromRGB(0, 130, 255),   -- Pure Neon Blue
    TextWhite    = Color3.fromRGB(255, 255, 255), -- Crisp Bold White
    TextCyan     = Color3.fromRGB(140, 225, 255), -- Cyan Subtitle
    TextMuted    = Color3.fromRGB(170, 195, 230), -- Muted Body
    TextDark     = Color3.fromRGB(115, 145, 185)  -- Dark Subtext
}
```

---

## 2. กฎการออกแบบ UI

1. **Zero Emojis**: ห้ามใช้อีโมจิเด็ดขาด ให้ใช้ Asset IDs (`rbxassetid://...`) หรือ SVG ImageLabels แทน
2. **Typography**: ใช้ `Enum.Font.GothamBold` เป็นหลัก แสดงผลสองภาษา (ไทยตัวหนา + อังกฤษตัวพิมพ์ใหญ่)
3. **Floating Toggle Button**: ปุ่มลอยน้ำทรงกลมพร้อมขอบไฟหมุน 360° ต่อเนื่องด้วย `TweenService`
4. **Drag vs Click Separation**: แยกการลากย้ายปุ่มกับการคลิกเปิด/ปิดด้วยสูตร `(currentPos - clickStart).Magnitude < 6` พิกเซล
5. **Teardown ก่อนเรนเดอร์**: ทำการ `:Destroy()` UI เก่าใน `CoreGui` และ `PlayerGui` ก่อนสร้างหน้าต่างใหม่เสมอ
