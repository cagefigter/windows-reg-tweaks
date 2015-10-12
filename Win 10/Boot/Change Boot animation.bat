@echo off

REM change the windows boot screen

start "" /w "%~dp0win7bootupdatercmd.exe" boot.bs7

REM delete working files

del /f /q "%~dp0win7bootupdatercmd.exe"
del /f /q "%~dp0boot.bs7"

REM delete old source files

del /f /q /a "c:\bootmgr~1"
del /f /q "%systemroot%\system32\bootres~1.dll"
del /f /q "%systemroot%\system32\winload~1.exe"
del /f /q "%systemroot%\system32\winresume~1.exe"
del /f /q "%systemroot%\system32\en-us\winload.exe~1.mui"
del /f /q "%systemroot%\system32\en-us\winresume.exe~1.mui"

exit