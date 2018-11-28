title Remove Defender by CHEF-KOCH
@echo off
%~d0
cd %~d0%~p0
cls
echo.
echo.
echo.          PLEASE READ CAREFULLY!!!
echo.          
echo.          THIS WILL REMOVE WINDOWS DEFENDER
echo.
echo.          DEFENDER CAN NOT BE RE-INSTALLED TAKE PRECAUTIONS
echo.          
echo.          YOUR COMPUTER WILL RESTART TO COMPLETE THE PROCESS
echo.          
echo.          BE SURE YOU ARE READY TO RESTART BEFORE RUNNING THIS PROGRAM
echo.
echo=============================================================================
echo.
echo.          1) START REMOVAL
echo.
echo.
echo.          X) EXIT PROGRAM
echo.
echo=============================================================================
echo.
choice /C:12X /N /M "Enter Your Choice: "
if errorlevel 2 goto :quit
if errorlevel 1 goto :BEGIN
:BEGIN
CLS
echo.
echo.
echo.
echo================================================================================
echo                  PREPARING THE REGISTRY AND REMOVING PACKAGES
echo================================================================================
echo.
echo.
echo.
echo.
Reg.exe add "HKLM\SOFTWARE\Microsoft\.NETFramework" /v "OnlyUseLatestCLR" /t REG_DWORD /d "1" /f >nul 2>&1
for /F "tokens=2 delims==" %%I in ('%SystemRoot%\System32\wbem\wmic.exe DATAFILE WHERE name^="C:\\windows\\System32\\dism.exe" get Version /VALUE 2^>nul') do set "BUILD=%%I"
wimtweak.exe /o /n >nul 2>&1
cls
powershell "Get-WindowsPackage -online -packagename *defender* | foreach {Remove-WindowsPackage -online -norestart -PackageName $_.PackageName }" >nul 2>&1
echo.
echo.
echo.
echo================================================================================
echo                      MODIFYING FOLDERS AND REGISTRY KEYS
echo================================================================================
echo.
echo.
echo.
echo.

takeown /f "%PROGRAMFILES%\Windows Defender" >nul 2>&1
icacls "%PROGRAMFILES%\Windows Defender" /grant "Everyone":F >nul 2>&1
rd /q /s "%PROGRAMFILES%\Windows Defender" >nul 2>&1

takeown /f "%PROGRAMFILES%\Windows Defender Advanced Threat Protection" >nul 2>&1
icacls "%PROGRAMFILES%\Windows Defender Advanced Threat Protection" /grant "Everyone":F >nul 2>&1
rd /q /s "%PROGRAMFILES%\Windows Defender Advanced Threat Protection" >nul 2>&1

takeown /f "%ProgramFiles(x86)%\Windows Defender" >nul 2>&1
icacls "%ProgramFiles(x86)%\Windows Defender" /grant "Everyone":F >nul 2>&1
rd /q /s "%ProgramFiles(x86)%\Windows Defender" >nul 2>&1

takeown /f "%PROGRAMDATA%\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1
icacls "%PROGRAMDATA%\Microsoft\Windows Defender Advanced Threat Protection" /grant "Everyone":F >nul 2>&1
rd /q /s "%PROGRAMDATA%\Microsoft\Windows Defender Advanced Threat Protection" >nul 2>&1

takeown /f "%PROGRAMDATA%\Microsoft\Windows Security Health" >nul 2>&1
icacls "%PROGRAMDATA%\Microsoft\Windows Security Health" /grant "Everyone":F >nul 2>&1
rd /q /s "%PROGRAMDATA%\Microsoft\Windows Security Health" >nul 2>&1

takeown /f "%PROGRAMDATA%\Microsoft\Windows Defender" >nul 2>&1
icacls "%PROGRAMDATA%\Microsoft\Windows Defender" /grant "Everyone":F >nul 2>&1
rd /q /s "%PROGRAMDATA%\Microsoft\Windows Defender" >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{6D40A6F9-3D32-4FCB-8A86-BE992E03DC76}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{6D40A6F9-3D32-4FCB-8A86-BE992E03DC76}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\CLSID\{6D40A6F9-3D32-4FCB-8A86-BE992E03DC76}" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF}" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Microsoft.Windows.Defender" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Microsoft.Windows.Defender" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\AppUserModelId\Microsoft.Windows.Defender" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.SystemToast.SecurityCenter" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.SystemToast.SecurityCenter" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\AppUserModelId\Windows.SystemToast.SecurityCenter" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender.SecurityCenter" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender.SecurityCenter" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\AppUserModelId\Windows.Defender.SecurityCenter" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{F2102C37-90C3-450C-B3F6-92BE1693BDF2}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{F2102C37-90C3-450C-B3F6-92BE1693BDF2}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\CLSID\{F2102C37-90C3-450C-B3F6-92BE1693BDF2}" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{2559a1f2-21d7-11d4-bdaf-00c04f60b9f0}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\CLSID\{2559a1f2-21d7-11d4-bdaf-00c04f60b9f0}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\CLSID\{2559a1f2-21d7-11d4-bdaf-00c04f60b9f0}" /f >nul 2>&1

SetACL.exe -on "HKEY_CLASSES_ROOT\AppID\{2EB6D15C-5239-41CF-82FB-353D20B816CF}" -ot reg -actn setowner -ownr "n:Administrators" >nul 2>&1
SetACL.exe -on "HKEY_CLASSES_ROOT\AppID\{2EB6D15C-5239-41CF-82FB-353D20B816CF}" -ot reg -actn ace -ace "n:Administrators;p:full" >nul 2>&1
Reg.exe delete "HKEY_CLASSES_ROOT\AppID\{2EB6D15C-5239-41CF-82FB-353D20B816CF}" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:windowsdefender" /f >nul 2>&1
CLS
echo.
echo.
echo.
echo===========================================
echo YOUR COMPUTER WILL RESTART IN 10 SECONDS!
echo===========================================

timeout /t 10

powershell restart-computer & goto :xquit
:Quit
cls
echo.
echo.
echo===============
echo    EXITING
echo===============
timeout /t 3
exit
:xquit
exit