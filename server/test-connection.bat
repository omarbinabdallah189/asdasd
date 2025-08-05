@echo off
echo === Testing FiveM Server Connectivity ===
echo.

echo Testing connection to FiveM services...
ping -n 1 citizensmp.services.fivem.net >nul
if %errorlevel%==0 (
    echo ✓ Can reach FiveM services
) else (
    echo ✗ Cannot reach FiveM services - check internet connection
)

echo.
echo Testing DNS resolution...
nslookup citizensmp.services.fivem.net

echo.
echo Checking Windows Firewall status...
netsh advfirewall show allprofiles state

echo.
echo Press any key to continue...
pause >nul
