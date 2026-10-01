-- AquaBot v6 | อควาเรียมตกปลา RNG
-- รันครั้งเดียว UI ขึ้นทันที | RightShift=ซ่อน/แสดง | X=ปิด
local LP=game:GetService("Players").LocalPlayer
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS2=game:GetService("ReplicatedStorage")
for _,v in pairs(LP.PlayerGui:GetChildren()) do if v.Name=="AquaHub" then v:Destroy() end end
task.wait(0.1)
local AddPowerEv=RS2:FindFirstChild("AddPowerEvent",true)
local ClaimBonusEv=RS2:FindFirstChild("ClaimBonusPowerEvent",true)
local fishUI=LP.PlayerGui:WaitForChild("FishingUI",10)
local FishBtn=fishUI and fishUI:FindFirstChild("FishButton",true)
local ReelMG=fishUI and fishUI:FindFirstChild("ReelMinigameUI",true)
local ReelBtn=ReelMG and ReelMG:FindFirstChild("ReelButton",true)
local PowerBar=fishUI and fishUI:FindFirstChild("PowerBarContainer",true)
local statsGui=LP.PlayerGui:FindFirstChild("StatsGui")
local BonusBtn=statsGui and statsGui:FindFirstChild("BonusPowerBtn",true)
if not fishUI or not ReelBtn or not FishBtn then warn("[AquaBot] FishingUI not found!") return end
local function callSig(sig,...)
  local ok,conns=pcall(getconnections,sig)
  if not ok then return end
  for _,c in pairs(conns) do pcall(c.Function,...) end
end
local F={fish=false,lift=false}
local fishThread=task.spawn(function()
  while true do
    task.wait(0.08)
    if not F.fish then continue end
    local reelOn=ReelMG and ReelMG.Visible and ReelBtn.Visible
    local fishOn=FishBtn and FishBtn.Visible
    local powerOn=PowerBar and PowerBar.Visible
    if reelOn then
      callSig(ReelBtn.MouseButton1Down,0,0)
    elseif fishOn and powerOn then
      callSig(FishBtn.MouseButton1Down,0,0);task.wait(0.04)
      callSig(FishBtn.MouseButton1Up,0,0);task.wait(0.04)
      callSig(FishBtn.MouseButton1Click)
    elseif fishOn and not powerOn then
      callSig(FishBtn.MouseButton1Down,0,0);task.wait(0.05)
      callSig(FishBtn.MouseButton1Up,0,0);task.wait(0.05)
      callSig(FishBtn.MouseButton1Click);task.wait(0.4)
    end
  end
end)
local liftThread=task.spawn(function()
  while true do
    task.wait(0.07)
    if not F.lift then continue end
    local char=LP.Character
    if char then
      local t=char:FindFirstChildWhichIsA("Tool")
      if t then pcall(function()t:Activate()end);task.wait(0.03);pcall(function()t:Activate()end) end
    end
    if AddPowerEv then pcall(function()AddPowerEv:FireServer()end);task.wait(0.03);pcall(function()AddPowerEv:FireServer()end) end
    if BonusBtn and BonusBtn.Visible then
      if ClaimBonusEv then pcall(function()ClaimBonusEv:FireServer()end) end
      callSig(BonusBtn.MouseButton1Down,0,0);task.wait(0.05)
      callSig(BonusBtn.MouseButton1Up,0,0);callSig(BonusBtn.MouseButton1Click)
    end
  end
end)
local W=Color3.new(1,1,1);local AC=Color3.fromRGB(30,190,255);local GR=Color3.fromRGB(50,220,100)
local OR=Color3.fromRGB(255,145,30);local RD=Color3.fromRGB(220,50,80)
local BG=Color3.fromRGB(9,13,22);local CARD=Color3.fromRGB(16,22,36)
local TI=TweenInfo.new(0.15,Enum.EasingStyle.Quad)
local function tw(o,p2) TS:Create(o,TI,p2):Play() end
local function N(cls,props,par) local o=Instance.new(cls);for k,v in pairs(props or{}) do o[k]=v end;if par then o.Parent=par end;return o end
local function cr(o,r) N("UICorner",{CornerRadius=UDim.new(0,r or 8)},o) end
local SG=N("ScreenGui",{Name="AquaHub",ResetOnSpawn=false,DisplayOrder=9999,IgnoreGuiInset=true},LP.PlayerGui)
local Win=N("Frame",{Size=UDim2.new(0,275,0,305),Position=UDim2.new(0.72,0,0.03,0),BackgroundColor3=BG,ClipsDescendants=true},SG)
cr(Win,12);N("UIStroke",{Color=AC,Thickness=1.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},Win)
local Hdr=N("Frame",{Size=UDim2.new(1,0,0,42),BackgroundColor3=Color3.fromRGB(7,16,30),ZIndex=2},Win);cr(Hdr,12)
N("Frame",{Size=UDim2.new(1,0,0.5,0),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=Color3.fromRGB(7,16,30)},Hdr)
N("TextLabel",{Size=UDim2.new(1,-75,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text="🐠 AQUA BOT",TextColor3=AC,TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},Hdr)
local MB=N("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-62,0.5,-13),BackgroundColor3=CARD,Text="-",TextColor3=W,TextSize=14,Font=Enum.Font.GothamBold,ZIndex=4},Hdr);cr(MB,6)
local CB=N("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-32,0.5,-13),BackgroundColor3=RD,Text="X",TextColor3=W,TextSize=11,Font=Enum.Font.GothamBold,ZIndex=4},Hdr);cr(CB,6)
local body=N("Frame",{Size=UDim2.new(1,-14,1,-52),Position=UDim2.new(0,7,0,50),BackgroundTransparency=1},Win)
N("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},body)
local statF=N("Frame",{Size=UDim2.new(1,0,0,30),BackgroundColor3=Color3.fromRGB(10,18,32)},body);cr(statF,7)
local statLbl=N("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text="⏸ ปิดอยู่",TextColor3=Color3.fromRGB(130,165,210),TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},statF)
local function makeTog(icon,lbl,sub,col,setter)
  local f=N("Frame",{Size=UDim2.new(1,0,0,68),BackgroundColor3=CARD},body);cr(f,10)
  local str=N("UIStroke",{Color=Color3.fromRGB(20,42,70),Thickness=1.3,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},f)
  N("TextLabel",{Size=UDim2.new(0,44,1,0),Position=UDim2.new(0,5,0,0),BackgroundTransparency=1,Text=icon,TextSize=26,Font=Enum.Font.GothamBold},f)
  N("TextLabel",{Size=UDim2.new(1,-108,0,24),Position=UDim2.new(0,52,0,10),BackgroundTransparency=1,Text=lbl,TextColor3=W,TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},f)
  N("TextLabel",{Size=UDim2.new(1,-108,0,18),Position=UDim2.new(0,52,0,34),BackgroundTransparency=1,Text=sub,TextColor3=Color3.fromRGB(90,145,200),TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},f)
  local pill=N("Frame",{Size=UDim2.new(0,52,0,28),Position=UDim2.new(1,-60,0.5,-14),BackgroundColor3=Color3.fromRGB(22,35,52)},f);cr(pill,14)
  local kn=N("Frame",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,3,0.5,-11),BackgroundColor3=Color3.fromRGB(70,105,140)},pill);cr(kn,11)
  local on=false
  local btn=N("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=5},f)
  btn.MouseButton1Click:Connect(function()
    on=not on
    if on then tw(pill,{BackgroundColor3=col});tw(kn,{Position=UDim2.new(1,-25,0.5,-11),BackgroundColor3=W});str.Color=col;str.Thickness=1.8;tw(f,{BackgroundColor3=col:Lerp(BG,0.85)})
    else tw(pill,{BackgroundColor3=Color3.fromRGB(22,35,52)});tw(kn,{Position=UDim2.new(0,3,0.5,-11),BackgroundColor3=Color3.fromRGB(70,105,140)});str.Color=Color3.fromRGB(20,42,70);str.Thickness=1.3;tw(f,{BackgroundColor3=CARD}) end
    setter(on)
  end)
  btn.MouseEnter:Connect(function() if not on then tw(f,{BackgroundColor3=Color3.fromRGB(20,30,50)}) end end)
  btn.MouseLeave:Connect(function() if not on then tw(f,{BackgroundColor3=CARD}) end end)
end
makeTog("🎣","Auto Fish","Phase1→cast / Phase2→tap / Phase3→reel",GR,function(on) F.fish=on end)
makeTog("💪","Auto Lift x2 + Bonus","x2 Power + โบนัสอัตโนมัติ",OR,function(on) F.lift=on end)
task.spawn(function()
  local t=0
  while SG and SG.Parent do
    task.wait(0.2);t=t+1;local d=string.rep(".",t%4)
    if F.fish then
      local reel=ReelMG and ReelMG.Visible;local power=PowerBar and PowerBar.Visible;local ready=FishBtn and FishBtn.Visible
      if reel then local ttl=ReelMG:FindFirstChild("TimerBg",true);local tl=ttl and ttl:FindFirstChild("TimeText");statLbl.Text="🎣 ดึงกลับ "..(tl and tl.Text or "...");statLbl.TextColor3=GR
      elseif power then statLbl.Text="⚡ Tap! Power Bar"..d;statLbl.TextColor3=Color3.fromRGB(255,220,30)
      elseif ready then statLbl.Text="🎯 เริ่มตกปลา"..d;statLbl.TextColor3=Color3.fromRGB(100,210,255)
      else statLbl.Text="🌊 รอได้ทำ"..d;statLbl.TextColor3=Color3.fromRGB(80,150,220) end
    elseif F.lift then
      local bonus=BonusBtn and BonusBtn.Visible
      statLbl.Text=bonus and "🟡 คลิ๊กโบนัส!" or ("💪 Lifting"..d);statLbl.TextColor3=bonus and Color3.fromRGB(255,220,30) or OR
    else statLbl.Text="⏸ ปิดอยู่";statLbl.TextColor3=Color3.fromRGB(120,155,200) end
  end
  task.cancel(fishThread);task.cancel(liftThread)
end)
local dg,ds,dp=false,nil,nil
Hdr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true;ds=i.Position;dp=Win.Position end end)
UIS.InputChanged:Connect(function(i) if dg and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-ds;Win.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=false end end)
local mn=false
MB.MouseButton1Click:Connect(function() mn=not mn;TS:Create(Win,TI,{Size=UDim2.new(0,275,0,mn and 42 or 305)}):Play();MB.Text=mn and "+" or "-" end)
CB.MouseButton1Click:Connect(function() F.fish=false;F.lift=false;task.cancel(fishThread);task.cancel(liftThread);SG:Destroy() end)
local hidden=false
UIS.InputBegan:Connect(function(i,gp) if gp then return end;if i.KeyCode==Enum.KeyCode.RightShift then hidden=not hidden;Win.Visible=not hidden end end)
