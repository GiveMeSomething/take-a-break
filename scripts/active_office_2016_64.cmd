set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

@echo Please wait until the operation is done

cd C:\Program Files\Microsoft Office\Office16
cscript OSPP.VBS /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
cscript OSPP.VBS /sethst:kms.digiboy.ir
cscript OSPP.VBS /act
cscript OSPP.VBS /dstatus

cls
@echo Have a good day.
@echo SaltyTuna