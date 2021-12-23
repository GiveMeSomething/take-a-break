@echo off

set secondToHour=3600
set secondToMinute=60

rem This will be run when user want to continue using
:YESOPTION

cls

rem This will be run when user enter wrong/invalid time
:WRONGINPUT
set time=
set timeoption=
set realtime=
set choice=

rem This option will make the var in block () to be use outside. Mostly for 'set' command for-loop and if statements 
setlocal enabledelayedexpansion

set /p time=Enter time (second) or choose pre-defined time: ^

1. 30' ^

2. 45' ^

3. 1h ^

4. 1h30' ^

5. 2h ^

Your selection:

rem set time to arithmetic type, if the time is text then the value is '0'
set /a test=%time%
if !test! EQU 0 (
	if !test! NEQ 0 (
		@echo ^

Invalid input! Please re-enter time ^ 


		goto WRONGINPUT
	)
)
rem Check for out-of-bound value. 'timeout' command accept from 0-9999 (I excluded 0)
if !test! LEQ 0 (
		@echo ^

Invalid time! Please re-enter time ^ 

		
		goto WRONGINPUT
)

if !test! GTR 9999 (
		@echo ^

Invalid time! Please re-enter time ^ 


		goto WRONGINPUT
)

set realtime=%time%

if "%time%" == "1" (set realtime=1800)
if "%time%" == "2" (set realtime=2700)
if "%time%" == "3" (set realtime=3600)
if "%time%" == "4" (set realtime=5400)
if "%time%" == "5" (set realtime=7200)

set time=!realtime!
set /a hour=0
set /a minute=0

rem If the time is greater than 3600 (1 hour) then set time and minute, else set only minute
if !time! GEQ 3600 (
	set /a hour=%time%/%secondToHour%
	set /a time-=!hour!*%secondToHour%
	set /a minute=!time!/%secondToMinute%
	set /a time-=!minute!*%secondToMinute%
) else (
	set /a minute=!time!/%secondToMinute%
	set /a time-=!minute!*%secondToMinute%
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
set /p choice="Continue using[Y/N]?"

if "%choice%" == "Y" (goto YESOPTION)
if "%choice%" == "y" (goto YESOPTION)

if "%choice%" == "N" (goto NOOPTION)
if "%choice%" == "n" (goto NOOPTION) else (
	@echo ^
	
Invalid input! Please enter 'Y' or 'N'.^


	goto ASKCONTINUE
)

:NOOPTION
@echo Thanks for using this scripts ^

This scripts will shutdown in 5 seconds
timeout /nobreak 5
exit