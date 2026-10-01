@echo off
chcp 65001 >nul
title 2K // OBSIDIAN CORE — INSTALLER & LAUNCHER
color 0B
echo ======================================================================
echo    2K OBSIDIAN STEALTH // SKILL & 3D DASHBOARD AUTO-INSTALLER
echo ======================================================================
echo.

set "SCRIPT_DIR=%~dp0"
set "GLOBAL_SKILL_DIR=%USERPROFILE%\.gemini\antigravity\skills\roblox-scripting"

echo [1/3] ติดตั้ง Skill ให้กับ Antigravity / Agent ในเครื่องนี้...
if exist "%SCRIPT_DIR%.agents\skills\roblox-scripting" (
    if not exist "%USERPROFILE%\.gemini\antigravity\skills" (
        mkdir "%USERPROFILE%\.gemini\antigravity\skills" 2>nul
    )
    xcopy /E /I /Y "%SCRIPT_DIR%.agents\skills\roblox-scripting" "%GLOBAL_SKILL_DIR%" >nul
    echo       [+] ติดตั้ง Skill roblox-scripting สำเร็จ!
) else (
    echo       [-] ไม่พบโฟลเดอร์ .agents\skills ในชุดนี้ (ข้าม)
)

echo.
echo [2/3] เริ่มการทำงานของ Server (Port 8080)...
start /min "2K-Server" python "%SCRIPT_DIR%server.py"
echo       [+] Web & Telemetry API Server รันบนพอร์ต 8080 แล้ว

echo.
echo [3/3] เปิดหน้าต่าง 3D Knowledge Core บนเบราว์เซอร์...
timeout /t 2 >nul
start http://localhost:8080/3D_Knowledge_Graph.html

echo.
echo ======================================================================
echo    ติดตั้งและเปิดใช้งานเรียบร้อยแล้ว! พร้อมลุย
echo ======================================================================
echo.
pause
