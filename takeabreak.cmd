setlocal enabledelayedexpansion
@echo off
set /p time=Enter time (second) or choose pre-defined time: ^

1. 30' ^

2. 45' ^

3. 1h ^

4. 1h30' ^

5. 2h ^

Your selection: 
set realtime=%time%
if "%time%" == "1" (set realtime=1800)
if "%time%" == "2" (set realtime=2700)
if "%time%" == "3" (set realtime=3600)
if "%time%" == "4" (set realtime=5400)
if "%time%" == "5" (set realtime=7200)
@echo Computer will enter hibernate after !realtime! seconds
timeout /nobreak !realtime!
shutdown -h
cmd /k