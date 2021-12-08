setlocal
@echo off

set /p a="Enter a:"
@echo a=%a%
set /p b="Enter b:"
@echo b=%b%

set /a result=%a%*%b%
@echo a+b=%result%

cmd /k