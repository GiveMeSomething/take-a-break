@echo off

set database=
set password=
set download=0

set /p database=Enter a database name: 


set /p password=Enter sa account password: 


set /p download=Download new package? (0 = No, 1 = Yes): 


if "%download%" == "1" (
	dotnet add package Microsoft.EntityFrameworkCore.Design --version 6.0.9
	dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 6.0.9
)

dotnet ef dbcontext scaffold -o Models -f -d "server=(local);database=%database%;uid=sa;pwd=%password%;" "Microsoft.EntityFrameworkCore.SqlServer"