@echo off
setlocal enableextensions enabledelayedexpansion
::
::Will stop services Diagnostic Tracking Service (diagtrack) and dmwappushservice (dmwappushsvc)
::
:BEGIN
echo.
		echo This script MUST be ran as an Administrator in order to work.
echo.
	choice /M "Did you run this as Administrator?"
		If Errorlevel 2 echo Right click the .bat file and run as Administrator & GOTO END
echo.
		echo Checking state of the Diagnostic Tracking Service... & timeout 1 >nul
echo.
		sc query "diagtrack" & timeout 1 >nul
echo.
				sc query "diagtrack" | findstr "STATE" | findstr "RUNNING" > nul
						if %errorlevel% == 1 GOTO DIAG_STOPPED
						if %errorlevel% == 0 GOTO DIAG_RUNNING
				echo unknown status
GOTO END
::
:DIAG_STOPPED
		echo The diagtrack service state is stopped.
		echo This should prevent the dmwappushservice service from running. & timeout 1 >nul
GOTO CHECK_PUSH
::
:DIAG_RUNNING
		echo The diagtrack service is running. & timeout 1 >nul
echo.
	choice /M "Do you want to stop service?"
		If Errorlevel 2 GOTO END
echo.
		echo Stopping diagtrack service and disabling from startup & timeout 1 >nul
echo.
								sc  stop "diagtrack" & timeout 1 >nul
echo.	
								sc config "diagtrack" start= disabled & timeout 1 >nul
echo.
				sc query "diagtrack" | findstr "STATE" | findstr "RUNNING" > nul
						if %errorlevel% == 1 GOTO DIAG_STOP_SUCCESS
						if %errorlevel% == 0 GOTO DIAG_STOP_FAIL
				echo unknown status
GOTO END
::
:DIAG_STOP_SUCCESS
echo.
		echo The Diagtrack service has been stopped!
		echo This should automatically disable the dmwappushservice service. & timeout 1 >nul
GOTO CHECK_PUSH
::
:DIAG_STOP_FAIL
echo.
		echo Diagtrack service is still running.. I give up.
		echo Maybe try and run this as Administrator.
				pause
GOTO END
::
:CHECK_PUSH
echo.
			echo Checking the state of dmwappushservice just in case...
echo.
			timeout 1 >nul
		sc query "dmwappushsvc" >nul & timeout 1 >nul
echo.
		sc query "dmwappushsvc" | findstr "STATE" | findstr "RUNNING" > nul
				if %errorlevel% == 1 GOTO PUSH_STOPPED
				if %errorlevel% == 0 GOTO PUSH_RUNNING
		echo unknown status
GOTO END
::
:PUSH_STOPPED
		echo The dmwappushsvc service state is stopped & timeout 1 >nul
GOTO END
::
:PUSH_RUNNING
		echo Push srvice is running. & timeout 1 >nul
echo.
	choice /M "Do you want to stop service?"
		If Errorlevel 2 GOTO END
echo.
		echo Stopping dmwappushsvc service and disabling from startup & timeout 1 >nul
echo.
								sc  stop "dmwappushsvc" & timeout 1 >nul
echo.	
								sc config "dmwappushsvc" start= disabled & timeout 1 >nul
echo.
				sc query "dmwappushsvc" | findstr "STATE" | findstr "RUNNING" > nul
						if %errorlevel% == 1 GOTO PUSH_STOP_SUCCESS
						if %errorlevel% == 0 GOTO PUSH_STOP_FAIL
				echo unknown status
GOTO END
::
:PUSH_STOP_SUCCESS
echo.
		echo Push service has been stopped & timeout 1 >nul
GOTO CHECK_PUSH
::
:PUSH_STOP_FAIL
echo.
		echo Push service is still running.. I give up.
		echo Maybe try and run this as Administrator.
				pause
GOTO END
::
:END
echo.
		echo Nothing left to do.
echo.
pause 
