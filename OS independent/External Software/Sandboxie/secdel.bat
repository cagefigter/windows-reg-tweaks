:: Program to secure delete files from a sandbox and shutdown the computer at the end.

@ECHO off

endlocal

setlocal enableextensions enabledelayedexpansion

:: Date
set dd=%date%
FOR %%A IN (%dd:/=%) DO SET dd=%%A

:: Time
set tt=%time:~0,5%
FOR %%C IN (%tt::=%) DO SET tt=%%C

echo.
echo.


:: Request from user to shutdown after delete.

set /p delbox=Would You Like To Shutdown After Deleting Sandbox. [y/n]?: 
if "!delbox!"=="y" (
GOTO deleteandshutdown
) else (
GOTO deleteonly
)


:: Delete and shutdown code.

:deleteandshutdown

::Delete existing logfile.	
del "delete*.txt"
echo.
@echo Delete and Shutdown >> delete_%dd%%tt%.txt
echo.

:: Request Sandboxie start.exe to terminate all programs in any sandbox.
"C:\Program Files\Sandboxie\Start.exe" /silent /terminate_all

:: Use Sdelete to secure delete the appropriate sandbox.
"C:\SDelete\sdelete.exe" -p 1 -s C:\Sandbox\Paul\Browser >> delete_%dd%%tt%.txt

:: Use Sandboxie start.exe to delete folder remenants that Sdelete is not authorised to.
"C:\Program Files\Sandboxie\Start.exe" /box:Browser /silent delete_sandbox

:: Shutdown computer.
"c:\windows\system32\shutdown.exe" -s	

echo.
@echo Ta-Ra Chuck! >> delete_%dd%%tt%.txt
pause >nul
endlocal
exit

:: Delete only code.

:deleteonly

::Delete existing logfile.
del "delete*.txt"
echo.
@echo Delete Only >> delete_%dd%%tt%.txt
echo.

:: Request Sandboxie start.exe to terminate programs only in the appropriate sandbox.
"C:\Program Files\Sandboxie\Start.exe" /box:Browser /terminate

:: Use Sdelete to secure delete the appropriate sandbox.
"C:\SDelete\sdelete.exe" -p 1 -s C:\Sandbox\Paul\Browser >> delete_%dd%%tt%.txt

:: Use Sandboxie start.exe to delete folder remenants that Sdelete is not authorised to.
"C:\Program Files\Sandboxie\Start.exe" /box:Browser delete_sandbox

echo.
@echo Press Any Key
pause >nul
endlocal
exit