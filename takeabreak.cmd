@echo off

rem This will be run when user want to continue using
:YESOPTION

cls

rem This will be run when user enter wrong/invalid time
:WRONGINPUT
set time=
set timeoption=
set multiplier=1
set realtime=
set choice=
set secondToHour=3600
set secondToMinute=60

rem This option will make the var in block () to be use outside. Mostly for 'set' command for-loop and if statements 
setlocal enabledelayedexpansion

rem Begin of the script
set /p time=Enter time (second) or choose pre-defined time: ^

1. 30' ^

2. 45' ^

3. 1h ^

4. 1h30' ^

5. 2h ^

6. Pomodoro (under-development) ^

Your selection: 

rem set time to arithmetic type, if the time is text then the value is '0'

set /a test=%time%
if !test! EQU 0 (
	if !time! NEQ 0 (
		@echo ^

Invalid input! Please re-enter time ^ 


		goto WRONGINPUT
	)
)


rem Check for out-of-bound value. 'timeout' command accept from 0-9999 (I excluded 0)
if !time! LEQ 0 (
		@echo ^

Invalid time! Please re-enter time ^ 

		
		goto WRONGINPUT
)

if !time! GTR 9999 (
		@echo ^

Invalid time! Please re-enter time ^ 

		
		goto WRONGINPUT
)

set /a time=%time%

if "%time%" == "1" (
	set realtime=1800
	goto NOTIMEOPTION
)
if "%time%" == "2" (
	set realtime=2700
	goto NOTIMEOPTION
)
if "%time%" == "3" (
	set realtime=3600
	goto NOTIMEOPTION
)
if "%time%" == "4" (
	set realtime=5400
	goto NOTIMEOPTION
)
if "%time%" == "5" (
	set realtime=7200
	goto NOTIMEOPTION
)

goto TIMEOPTION

:TIMEOPTION

set /p timeoption="Enter time options [M]inute | [S]econd (Default): "

if "%timeoption%" == "M" (
	set multiplier=60

	@echo Time now calculate in MINUTE
)
if "%timeoption%" == "m" (
	set multiplier=60

	@echo Time now calculate in MINUTE
) else (

	@echo Time now calculate in SECOND

)

set /a timevalue = %time%
set /a realtime=%time%*%multiplier%

goto NOTIMEOPTION

:NOTIMEOPTION

set time=!realtime!

rem set default hour and minute value
set hour=0
set minute=0

rem If the time is greater than 3600 (1 hour) then set time and minute, else set only minute
if !time! GEQ 3600 (
	set /a hour=%time%/%secondToHour%

	set /a time -= !hour!*%secondToHour%

	set /a minute=!time!/%secondToMinute%

	set /a time -= !minute!*%secondToMinute%
) else (
	set /a minute=!time!/%secondToMinute%

	set /a time -= !minute!*%secondToMinute%
)

rem Weird script to add hour and minute to current time. Will look into it later!!!
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(!minute!).AddHours(!hour!).ToString('yyyy/MM/dd HH:mm:ss')"
') do (
  set "AddedTime=%%B"
)

@echo Computer will enter hibernate at %AddedTime%, in !hour! hour(s), !minute! minute(s) and !time! second(s)

timeout /nobreak !realtime!

rundll32.exe user32.dll,LockWorkStation

rem Ask the user if the script should continue
:ASKCONTINUE
set /p choice=Continue using[Y/N]?

if "%choice%" == "Y" (goto YESOPTION)
if "%choice%" == "y" (goto YESOPTION)

if "%choice%" == "N" (goto NOOPTION)
if "%choice%" == "n" (goto NOOPTION) else (
	@echo ^
	
Invalid input! Please enter 'Y' or 'N'.^


	goto ASKCONTINUE
)

rem Fallback option
goto END

:NOOPTION
@echo Thanks for using this scripts ^

This scripts will shutdown in 5 seconds
timeout /nobreak 5
exit

rem Pomodoro feature. Will develop later
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