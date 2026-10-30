@echo off
REM Launch the Third Age static recomp with the USB controller stack enabled.
REM Double-clicking the exe directly does NOT set RECOMP_USB, and the game is
REM unplayable without it: no pad is ever enumerated. The working directory must
REM also be the repo root, where dump\game_files\ lives.
title The Third Age (recomp)
cd /d "%~dp0"
set RECOMP_USB=1
REM The 3D path renders at well under one frame a second without this; the
REM cutscene advances per presented frame, so leaving it unset makes the intro
REM look like a freeze. 10 is what the gameplay lane measured 4-20 fps with.
set RECOMP_FRAMESKIP=10
echo Starting with RECOMP_USB=1 and RECOMP_FRAMESKIP=10 ...
echo   menu appears after roughly 45-70 seconds; the prologue movie follows.
echo.
REM Do not use "start" here: detaching the game lets its console close underneath
REM it, and the framebuffer window goes with it -- which looks like an instant
REM crash while the process lingers with no window.
"%~dp0build\Release\third_age_recomp.exe" 2>"%~dp0third_age_run.log"
echo.
echo Game exited with code %ERRORLEVEL%.
powershell -NoProfile -Command "Get-Content -Tail 8 '%~dp0third_age_run.log'"
pause
