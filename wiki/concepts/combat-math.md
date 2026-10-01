# Combat & Spatial Math (Auto Parry & Targeting)

สูตรคณิตศาสตร์เชิงพื้นที่สำหรับระบบต่อสู้อัตโนมัติ (Blade Ball, WarzPVP, Aimbot)

---

## 1. Time to Impact (การคำนวณเวลาการเข้าชน)

ใช้สำหรับระบบ Auto Parry (เช่น Blade Ball) เพื่อประเมินเวลาที่ลูกบอลหรือกระสุนจะพุ่งมาถึงตัวละคร:

```luau
local function calculateTimeToImpact(projPosition: Vector3, projVelocity: Vector3, targetPosition: Vector3): number
    local distance = (projPosition - targetPosition).Magnitude
    local speed = projVelocity.Magnitude
    if speed <= 0.1 then return math.huge end

    -- คำนวณทิศทางการเคลื่อนที่ด้วย Dot Product
    local direction = projVelocity.Unit
    local toTarget = (targetPosition - projPosition).Unit
    local dot = direction:Dot(toTarget)

    -- ถ้า dot > 0.5 แสดงว่าวิถีกำลังพุ่งตรงเข้ามาหาเป้าหมาย
    if dot > 0.5 then
        return distance / speed
    end
    return math.huge
end
```

---

## 2. Ping Offset & Parry Timing

การกดยิงหรือ Parry ต้องชดเชยค่าความหน่วงของเซิร์ฟเวอร์ (Ping / Latency):

```luau
local function shouldParry(timeToImpact: number, pingMs: number, customThreshold: number): boolean
    local pingSeconds = (pingMs / 1000)
    local effectiveThreshold = (customThreshold or 0.25) + pingSeconds
    return timeToImpact <= effectiveThreshold
end
```
