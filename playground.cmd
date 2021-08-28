@echo off
set /p "var1=enter minutes to add: "
set /p "var2=enter hours to add: "
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(%var1%).AddHours(%var2%).ToString('yyyy/MM/dd HH:mm:ss')"
') do (
  Set "MyDate=%%A"
  set "MyTime=%%B"
)
echo %MyTime%

cmd /k