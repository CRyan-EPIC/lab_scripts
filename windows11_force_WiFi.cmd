@echo off
set SSID=EPIC-CompSci-WiFi-5GHz

echo Clearing existing filters...
netsh wlan delete filter permission=allow ssid=* networktype=infrastructure
netsh wlan delete filter permission=block ssid=* networktype=infrastructure

echo Blocking all SSIDs except %SSID%...
netsh wlan add filter permission=block ssid=all networktype=infrastructure
netsh wlan add filter permission=allow ssid=%SSID% networktype=infrastructure

echo.
echo Only %SSID% is now allowed.
pause


REM sfc /scannow
sfc /scannow


REM Change the hostname
@echo off
:: Rename-Framework.cmd
:: Renames this PC to the format: framework-###-##
:: Example: framework-214-05

setlocal enabledelayedexpansion

echo ===============================================
echo   EPIC Framework Computer Renamer
echo ===============================================
echo.

:BUILDING
set /p building=Enter building number (214 or 226): 
if "%building%"=="214" goto VALIDBUILDING
if "%building%"=="226" goto VALIDBUILDING
echo Invalid building number. Please enter 214 or 226.
goto BUILDING

:VALIDBUILDING
set /p compnum=Enter computer number (1-24): 

:: Check if number is valid
set /a testnum=%compnum%+0 2>nul
if %testnum% lss 1 goto INVALIDNUM
if %testnum% gtr 24 goto INVALIDNUM

:: Pad single-digit numbers with leading zero
if %compnum% lss 10 set compnum=0%compnum%

set newname=framework-%building%-%compnum%

echo.
echo Renaming computer to: %newname%
echo.

:: Use PowerShell Rename-Computer for reliability
powershell -Command "Rename-Computer -NewName '%newname%' -Force -Restart"

goto END

:INVALIDNUM
echo Invalid computer number. Please enter 1 through 24.
goto VALIDBUILDING

:END
endlocal
exit /b
