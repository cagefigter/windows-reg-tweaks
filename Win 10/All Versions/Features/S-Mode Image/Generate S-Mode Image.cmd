@echo off

REM Change current directory from %SystemRoot%\System32 to directory where script is, it was tested with Build Windows 10 17604.
%~d0
cd %~dp0

title Windows 10 S Mode Install Image Creation Tool

REM Create temporary scratch directory for mounting install image
mkdir scratch

REM Mount install.wim to temporary scratch directory
dism.exe /Mount-Wim /WimFile:%cd%\install.wim /index:1 /MountDir:%cd%\scratch

REM Load SYSTEM hive from mounted install image to HKEY_LOCAL_MACHINE\TEMPSYS
reg.exe load HKLM\TEMPSYS %cd%\scratch\Windows\System32\config\SYSTEM

REM Set SkuPolicyRequired to 1 to enable S mode
reg.exe add HKLM\TEMPSYS\ControlSet001\Control\CI\Policy /f /v SkuPolicyRequired /t REG_DWORD /d 1

REM Unload temporary system hive
reg.exe unload HKLM\TEMPSYS

REM Unmount & commit install image
dism.exe /Unmount-Wim /MountDir:%cd%\scratch /commit

REM Remove temporary scratch directory
rmdir scratch

pause