@echo off
@setlocal enabledelayedexpansion
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ERROR: Please run this script as admin!
    echo.
    pause
    exit
)
echo =============================
echo DISABLE WINDOWS 10 SYSTEMAPPS
echo =============================
echo.
echo Disabling Apps...
echo.
cd C:\Windows\SystemApps
for /f %%f in ('dir /b C:\Windows\SystemApps') do (
    cd %%f
    for %%* in (.) do set CurrDirName=%%~nx*
    if NOT "!CurrDirName!"=="!CurrDirName:ShellExp=!" (
        cd ..
    ) else (
        for /r %%x in (*.exe) do TASKKILL /F /IM %%~nxx
        cd ..
        ren %%f disabled_%%f
    )
)
echo.
echo FINISHED!
pause