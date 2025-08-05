@echo off
echo === FiveM Server Diagnostic Tool ===
echo.
echo Checking server configuration...
echo.

REM Check if port is available
echo Checking port 30121 availability...
netstat -ano | findstr :30121
if %errorlevel%==0 (
    echo WARNING: Port 30121 is already in use!
) else (
    echo Port 30121 is available.
)

echo.
echo Checking server files...
if exist "FXServer.exe" (
    echo FXServer.exe found.
) else (
    echo ERROR: FXServer.exe not found!
)

echo.
echo Checking resource directories...
if exist "resources\vMenu\vMenu-v3.7.0" (
    echo vMenu resource found.
) else (
    echo ERROR: vMenu resource not found!
)

if exist "resources\screenshot-basic" (
    echo screenshot-basic resource found.
) else (
    echo ERROR: screenshot-basic resource not found!
)

if exist "resources\hackdetect" (
    echo hackdetect resource found.
) else (
    echo ERROR: hackdetect resource not found!
)

echo.
echo Checking server.cfg syntax...
findstr /c:"sv_hostname" server.cfg >nul
if %errorlevel%==0 (
    echo server.cfg basic syntax appears valid.
) else (
    echo WARNING: server.cfg may have syntax issues.
)

echo.
echo === Diagnostic Complete ===
echo.
echo Common issues for "starting game" hang:
echo 1. Port conflict (check if 30121 is in use)
echo 2. Missing or corrupted resources
echo 3. Incorrect sv_licenseKey
echo 4. Firewall blocking connections
echo 5. Missing dependencies or .NET framework
echo.
pause
