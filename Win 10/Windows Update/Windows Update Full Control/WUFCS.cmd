: ********************************************************************
: Put the .cmd script and the Windows Update MiniTool in the same
: folder/location i.e. X:\WindowsUpdateControl.
: *******************************************************************
: This utility enables automatic updates,
: then runs the Windows Update MiniTool,
: and then disables automatic updates
: giving you full control. No more automatic
: update reboots.
:::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights
:::::::::::::::::::::::::::::::::::::::::
@echo off
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
ECHO For Each strArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
ECHO args = args ^& strArg ^& " "  >> "%temp%\OEgetPrivileges.vbs"
ECHO Next >> "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*
exit /B

:gotPrivileges
if '%1'=='ELEV' shift /1
setlocal & pushd .
cd /d %~dp0

::::::::::::::::::::::::::::
::START
::::::::::::::::::::::::::::
echo ****************************** 
echo This utility enables automatic updates,
echo then runs the Windows Update MiniTool,
echo and then disables automatic updates
echo giving you full control. No more automatic
echo update reboots.
echo ******************************
@echo off
pause
cls
echo *** Enabling Windows Updates ***
@echo on
sc config wuauserv start= auto
net start wuauserv
@echo off
echo **********************************************************
echo Press a key to run Windows Update MiniTool.
echo Don't close this window or automatic updates will stay on!
echo Return to this window when finished with WUMT.
echo **********************************************************
pause
@echo off
:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64BIT
wumt_x64.exe
GOTO END
:32BIT
wumt_x86.exe
GOTO END
:END
@cls
@echo off
echo **************************************************
echo Press a key to disable automatic updates (recommended), or
echo ctrl-c to exit and leave automatic updates turned on (if you must).
echo ***************************************************
pause > nul
@echo on
sc config wuauserv start= disabled
net stop wuauserv
@echo off
echo **************************
echo Windows Update Completed.
echo Press a key to exit.
echo **************************
pause > nul