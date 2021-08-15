@echo off

:YESOPTION

cls
set time=
set realtime=
set choice=

setlocal enabledelayedexpansion
set /p time=Enter time (second) or choose pre-defined time: ^

1. 30' ^

2. 45' ^

3. 1h ^

4. 1h30' ^

5. 2h ^

6. Pomodoro (experimental) ^

Your selection: 

set realtime=%time%

if "%time%" == "1" (set realtime=1800)
if "%time%" == "2" (set realtime=2700)
if "%time%" == "3" (set realtime=3600)
if "%time%" == "4" (set realtime=5400)
if "%time%" == "5" (set realtime=7200)
if "%time%" == "6" (goto POMODOROSTART)

@echo Computer will enter hibernate after !realtime! seconds

timeout /nobreak !realtime!

shutdown -h

set /p choice=Continue using[Y/N]?

if "%choice%" == "Y" (goto YESOPTION)
if "%choice%" == "y" (goto YESOPTION)

if "%choice%" == "N" (goto NOOPTION)
if "%choice%" == "n" (goto NOOPTION)

goto END

:NOOPTION
@echo Thanks for using this scripts ^

This scripts will shutdown in 5 seconds
timeout /nobreak 5
exit

:POMODOROSTART
@echo ^

This timer will run 4 times, 25 mins each, with 3 breaks ^

Please take a big break after that ^



set pomodorotime=0

:POMODOROLOOP
set /a numtime=pomodorotime + 1
set pomodorotime=%numtime%

@echo Starting loop number %pomodorotime%
timeout /nobreak 1500
start "" cmd /wait /c "echo End of loop&echo Please take a break&echo This window will automically close in 10 seconds&timeout 30& exit"

if %pomodorotime% == 4 (goto POMODOROEND) else (goto POMODOROCHOICE)

:POMODOROCHOICE
set /p choice=Continue using[Y/N]?

if "%choice%" == "Y" (goto POMODOROLOOP)
if "%choice%" == "y" (goto POMODOROLOOP)

if "%choice%" == "N" (goto POMODOROEND)
if "%choice%" == "n" (goto POMODOROEND)

:POMODOROEND
@echo Congrats for completing a Pomodoro Cycle ^

Please take a 20-30 mins break to refresh your mind :3 ^

Computer will enter hibernate after 60 seconds
timeout /nobreak 60
shutdown -h

:END
cmd /k