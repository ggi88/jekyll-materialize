
@ECHO OFF
setlocal

:: init val
rem desctination
rem user
rem pass
rem flag

set destination=git:https://github.com

echo Clear Git Credentials
echo.

set /p user=input user id: 
set /p pass=input passowrd: 
echo The Info is User: %user%, Password: %pass%.
echo.
set /p flag=Continue? (Y/N)
echo %flag%
if /i %flag% == Y (
  goto NEXT
) else (
  goto QUIT
)

:NEXT
echo.
echo ======= start =======
echo.
echo delete Credentials
cmdkey /delete:%destination%
echo.
echo add Credentials
:: cmdkey /generic:%destination% /user:%user% /pass:%pass%
cmdkey /user:%destination% /user:%user% /pass:%pass%
echo.
echo read Credentials
cmdkey /list: %destination%
echo.
echo ======= end =======
GOTO:EOF

:QUIT
echo.
echo ======= end =======
GOTO:EOF


