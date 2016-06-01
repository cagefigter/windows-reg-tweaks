@echo off
schtasks /Delete /TN "Aero Glass" /F
echo Aero Glass is being installed...
setlocal enableextensions
cd /d "%~dp0"
echo ^<?xml version="1.0" encoding="UTF-16"?^>>task.xml
echo ^<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>>>task.xml
echo   ^<Triggers^>>>task.xml
echo     ^<BootTrigger^>>>task.xml
echo       ^<Enabled^>true^</Enabled^>>>task.xml
echo     ^</BootTrigger^>>>task.xml
echo   ^</Triggers^>>>task.xml
echo   ^<Principals^>>>task.xml
echo     ^<Principal id="Author"^>>>task.xml
echo       ^<RunLevel^>HighestAvailable^</RunLevel^>>>task.xml
echo     ^</Principal^>>>task.xml
echo   ^</Principals^>>>task.xml
echo   ^<Settings^>>>task.xml
echo     ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>>>task.xml
echo     ^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>>>task.xml
echo     ^<StopIfGoingOnBatteries^>false^</StopIfGoingOnBatteries^>>>task.xml
echo     ^<AllowHardTerminate^>false^</AllowHardTerminate^>>>task.xml
echo     ^<StartWhenAvailable^>true^</StartWhenAvailable^>>>task.xml
echo     ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>>>task.xml
echo     ^<IdleSettings^>>>task.xml
echo       ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>>>task.xml
echo       ^<RestartOnIdle^>false^</RestartOnIdle^>>>task.xml
echo     ^</IdleSettings^>>>task.xml
echo     ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>>>task.xml
echo     ^<Enabled^>true^</Enabled^>>>task.xml
echo     ^<Hidden^>false^</Hidden^>>>task.xml
echo     ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>>>task.xml
echo     ^<DisallowStartOnRemoteAppSession^>false^</DisallowStartOnRemoteAppSession^>>>task.xml
echo     ^<UseUnifiedSchedulingEngine^>false^</UseUnifiedSchedulingEngine^>>>task.xml
echo     ^<WakeToRun^>false^</WakeToRun^>>>task.xml
echo     ^<ExecutionTimeLimit^>PT0S^</ExecutionTimeLimit^>>>task.xml
echo     ^<Priority^>5^</Priority^>>>task.xml
echo     ^<RestartOnFailure^>>>task.xml
echo       ^<Interval^>PT1M^</Interval^>>>task.xml
echo       ^<Count^>3^</Count^>>>task.xml
echo     ^</RestartOnFailure^>>>task.xml
echo   ^</Settings^>>>task.xml
echo   ^<Actions Context="Author"^>>>task.xml
echo     ^<Exec^>>>task.xml
echo       ^<Command^>%CD%\aerohost.exe^</Command^>>>task.xml
echo     ^</Exec^>>>task.xml
echo   ^</Actions^>>>task.xml
echo ^</Task^>>>task.xml
schtasks /Create /RU SYSTEM /TN "Aero Glass" /XML task.xml
del task.xml
schtasks /Run /TN "Aero Glass"
rem pause