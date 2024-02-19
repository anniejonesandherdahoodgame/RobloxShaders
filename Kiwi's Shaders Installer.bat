title Kiwi's Roblox Shaders Installer

:: permission elevation from stackoverflow
echo Elevating permissions...
if "%2"=="firstrun" exit
cmd /c "%0" null firstrun

if "%1"=="skipuac" goto skipuacstart

echo Checking if ran as administrator...
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (shift & goto gotPrivileges)

echo Disabling UAC...
setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B

echo Successfully elevated permissions
:gotPrivileges
setlocal & pushd .

cd /d %~dp0
cmd /c "%0" skipuac firstrun
cd /d %~dp0

echo Starting program...
:skipuacstart
if "%2"=="firstrun" exit


:: don't mind my ugly code, this is from a while ago
@echo off
cls
mode 65, 25

for /d %%i in ("%localappdata%\Roblox\Versions\*") do (
if exist "%%i\RobloxPlayerBeta.exe" (
    set rblxversion=%%i
))

goto realmain

:filescheck
cls
if not exist "C:\Program Files\NVIDIA Corporation\NVIDIA GeForce Experience" (
    goto nvexp
        )
if not exist "%~dp0\shaders" (
    echo Make sure you installed everything from the latest release.
        pause
        start "" https://github.com/o5u3/RobloxShaders/releases/
        goto quit
        )
        goto main

:nvexp
cls
echo You need to install NVIDIA GeForce Experience.
pause
start "" https://www.nvidia.com/en-us/geforce/geforce-experience/
goto exit

:realmain
cls
echo ----------------Selection-----------------
echo.
echo Do you want to use NVIDIA or color shaders?
echo.
echo nvidia/regular
echo.
echo ---------------------------------------------
echo.
echo Copyright 2020 ilyKiwi. All rights reserved.
echo.
echo ---------------------------------------------

set /p ans="Enter Option: "

if "%ans%" == "nvidia" goto filescheck
if "%ans%" == "regular" goto main2
echo Enter a valid option.
pause
goto realmain

:main2
cls
echo ----------------Color Shaders-----------------
echo.
echo [1] Open Color Shaders (WINDOWS ^10 ONLY)
echo.
echo [2] Open Color Shaders (WINDOWS ^11 ONLY)
echo.
echo -------------------EXTRAS--------------------
echo.
echo [back] Return to selection
echo.
echo [discord] Join Discord Server
echo.
echo [0] Close
echo.
echo ---------------------------------------------
echo.
echo Copyright 2020 ilyKiwi. All rights reserved.
echo.
echo ---------------------------------------------

set /p ans="Enter Option: "

if "%ans%" == "1" goto colorshadersinstall
if "%ans%" == "2" goto colorshadersinstall2
if "%ans%" == "back" goto realmain
if "%ans%" == "discord" echo Redirecting to Discord Server Invite... & start "" https://discord.gg/CZUfHYHtZr & goto main
if "%ans%" == "0" goto quit
echo Enter a valid option.
pause
goto main2


:main
cls
echo -------------------NVIDIA--------------------
echo.
echo.
echo [1] Install NVIDIA Shaders
echo.
echo [2] Uninstall NVIDIA Shaders
echo.
echo [3] Run Roblox with NVIDIA Shaders
echo.
echo [4] Fix NVIDIA Shaders
echo.
echo -------------------EXTRAS--------------------
echo.
echo [back] Return to selection
echo.
echo [discord] Join Discord Server
echo.
echo [0] Close
echo.
echo ---------------------------------------------
echo.
echo Copyright 2020 ilyKiwi. All rights reserved.
echo.
echo ---------------------------------------------

set /p ans="Enter Option: "

if "%ans%" == "1" goto nvidiainstall
if "%ans%" == "2" goto uninstallnvidiashaders
if "%ans%" == "3" goto launchrobloxwithshaders1
if "%ans%" == "4" goto fixnvidiashaders
if "%ans%" == "back" goto realmain
if "%ans%" == "discord" echo Redirecting to Discord Server Invite... & start "" https://discord.gg/CZUfHYHtZr & goto main
if "%ans%" == "0" goto quit
echo Enter a valid option.
pause
goto main

:colorshadersinstall
cls
echo Starting dwmlut...
if exist "%~dp0\dwmlutW10" (start ""  "%~dp0\dwmlutW10\DwmLutGUI.exe") else (echo dwmlut folder not found, contact the owner. & pause & exit)
echo Select your main monitor, goto SDR LUT, browse, goto the dwlut folder, and select any color set.
echo.
echo Once you choose a color set, click apply. To revert changes, goto SDR LUT, and click the clear option, and apply.
echo.
pause
goto main2

:colorshadersinstall2
cls
echo Starting dwmlut...
if exist "%~dp0\dwmlutW11" (start ""  "%~dp0\dwmlutW11\DwmLutGUI.exe") else (echo dwmlut folder not found, contact the owner. & pause & exit)
echo Select your main monitor, goto SDR LUT, browse, goto the dwlut folder, and select any color set.
echo.
echo Once you choose a color set, click apply. To revert changes, goto SDR LUT, and click the clear option, and apply.
echo.
pause
goto main2

:fixnvidiashaders
cls
echo Starting GeForce Experience...
if exist "C:\Program Files\NVIDIA Corporation\NVIDIA GeForce Experience" (start ""  "C:\Program Files\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe") else (echo NVIDIA folder not found, contact the owner. & pause & exit)
echo Follow these instructions: 
echo.
echo Goto drivers, reinstall latest driver (3 dots), custom installation, enable perform a clean installation, install
pause
cls
echo NVIDIA shaders should be fixed after you reinstall it. Reinstall NVIDIA Shaders, and yes you have to follow the video again and everything.
timeout /t 8
goto uninstallnvidiashaders


:nvidiainstall
cls
::echo Follow the tutorial.
::start "" https://youtu.be/wkAHtGd2-xI
if exist "%~dp0\nvPI\nvidiaProfileInspector.exe" (start "" "%~dp0\nvPI\nvidiaProfileInspector.exe")
pause
echo Getting Roblox version...
if exist "%rblxversion%" (echo Roblox version found) else (echo Roblox version was not found. Contact the owner. & pause & goto exit)
echo Checking for NVIDIA folder...
if exist "C:\Program Files\NVIDIA Corporation" (echo NVIDIA folder found) else (echo Creating NVIDIA folder... & mkdir "C:\Program Files\NVIDIA Corporation")
echo Installing NVIDIA Shaders...
if exist "C:\Program Files\NVIDIA Corporation\Ansel" (echo Ansel already installed.) else (echo Ansel not found, creating... & mkdir "C:\Program Files\NVIDIA Corporation\Ansel")
pushd "%~dp0"
copy "shaders" "C:\Program Files\NVIDIA Corporation\Ansel"
popd
echo NVIDIA Shaders installed.
echo Searching for RobloxPlayerBeta.exe ...
if exist "%rblxversion%\RobloxPlayerBeta.exe" (echo RobloxPlayerBeta.exe found) else (echo Make sure you fully installed Roblox. & pause & goto quit)
echo Applying Shaders...
xcopy "%rblxversion%\RobloxPlayerBeta.exe" "%rblxversion%\eurotrucks2.exe*" /A /Y 
cls
echo Installed NVIDIA shaders. (MUST RUN ROBLOX THROUGH THIS PROGRAM)
timeout /t 8
goto main

:uninstallnvidiashaders
cls
echo Uninstalling Roblox shaders...
if exist "%rblxversion%\eurotrucks2.exe" (del "%rblxversion%\eurotrucks2.exe")
if exist "%rblxversion%\anselintegrationtestapp.exe" (del "%rblxversion%\anselintegrationtestapp.exe")
echo Uninstalling NVIDIA shaders...
if exist "C:\Program Files\NVIDIA Corporation\Ansel" (rmdir "C:\Program Files\NVIDIA Corporation\Ansel" /s /q)
echo Uninstalled shaders.
::echo Make sure to run NVIDIA Profile Inspector --> Other -->  Ansel flags for enabled applications to DISALLOWED
timeout /t 3
goto main

:launchrobloxwithshaders1
cls
if exist "%rblxversion%\eurotrucks2.exe" (start /d "%rblxversion%\" eurotrucks2.exe -arg & echo Launching Roblox with Shaders... Alt F3 to Open Shaders Menu) else (echo Make sure to install shaders before running Roblox & pause & goto main)
timeout /t 8
goto quit

:quit
cls
echo Quitting...
exit
