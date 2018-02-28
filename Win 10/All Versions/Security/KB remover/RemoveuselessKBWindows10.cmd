REM - REMOVES ALL Windows 10 Nagware! 

REM - KILLS and Disables Telemetry and related tasks...

REM - Hides ALL Updates - Get Windows 10, Telemetry & Nagware 
pause
timeout 3

REM --- Un-installing updates, please be patient...

:: REMOVE updates -----------------------------------------

REM kb971033 License validation check
start "title" /b /wait wusa.exe /kb:971033 /uninstall /quiet /norestart

REM kb2902907 Microsoft Security Essentials
start "title" /b /wait wusa.exe /kb:2902907 /uninstall /quiet /norestart

REM kb2922324 Telemetry
start "title" /b /wait wusa.exe /kb:2922324 /uninstall /quiet /norestart

REM kb2952664 Get Windows 10 assistant Compatibility update
start "title" /b /wait wusa.exe /kb:2952664 /uninstall /quiet /norestart

REM kb2976978 Compatibility update for Windows 8.1 and Windows 8
start "title" /b /wait wusa.exe /kb:2976978 /uninstall /quiet /norestart

REM kb2977759 W10 Diagnostics Compatibility telemetry
start "title" /b /wait wusa.exe /kb:2977759 /uninstall /quiet /norestart

REM kb2990214 Get Windows 10 for Windows 7
start "title" /b /wait wusa.exe /kb:2990214 /uninstall /quiet /norestart

REM kb3012973 Upgrade to Windows 10 Pro
start "title" /b /wait wusa.exe /kb:3012973 /uninstall /quiet /norestart

REM kb3014460 Upgrade for windows insider preview / upgrade to windows 10
start "title" /b /wait wusa.exe /kb:3014460 /uninstall /quiet /norestart


REM kb3015249 Upgrade that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
start "title" /b /wait wusa.exe /kb:3015249 /uninstall /quiet /norestart

REM kb3021917 Update to Windows 7 SP1 for performance improvements
start "title" /b /wait wusa.exe /kb:3021917 /uninstall /quiet /norestart

REM kb3022345 Telemetry (replaced with KB3068708)
start "title" /b /wait wusa.exe /kb:3022345 /uninstall /quiet /norestart

REM kb3035583 GWX Update installs get windows 10 app in Windows 8.1 and Windows 7 SP1
start "title" /b /wait wusa.exe /kb:3035583 /uninstall /quiet /norestart

REM kb3042058 Microsoft claims its a security update but it contains Winlogon Spying
start "title" /b /wait wusa.exe /kb:3042058 /uninstall /quiet /norestart

REM kb3044374 Get Windows 10 for W8,8.1
start "title" /b /wait wusa.exe /kb:3044374 /uninstall /quiet /norestart

REM kb3050265 Windows Update service updated to accept upgrade to W10
start "title" /b /wait wusa.exe /kb:3050265 /uninstall /quiet /norestart

REM kb3064683 Windows 8.1 OOBE modifications to reserve Windows 10
start "title" /b /wait wusa.exe /kb:3064683 /uninstall /quiet /norestart

REM kb3065987 Windows 10 Upgrade for Windows 7
start "title" /b /wait wusa.exe /kb:3065987 /uninstall /quiet /norestart

REM kb3065988 Windows 10 Upgrade for Windows 8
start "title" /b /wait wusa.exe /kb:3065988 /uninstall /quiet /norestart

REM kb3068707 Customer experience telemetry point (W7,8,8.1)
start "title" /b /wait wusa.exe /kb:3068707 /uninstall /quiet /norestart

REM kb3068708 Telemetry (replaces KB3022345) 
start "title" /b /wait wusa.exe /kb:3068708 /uninstall /quiet /norestart

REM kb3072318 Windows 10 Upgrade preparation for Windows 8
start "title" /b /wait wusa.exe /kb:3072318 /uninstall /quiet /norestart

REM kb3074677 Windows 10 Upgrade preparation
start "title" /b /wait wusa.exe /kb:3074677 /uninstall /quiet /norestart

REM kb3075249 Telemetry for Win7/8.1
start "title" /b /wait wusa.exe /kb:3075249 /uninstall /quiet /norestart

REM kb3075853 Update for Windows Update on Win8.1/Server 2012R2
start "title" /b /wait wusa.exe /kb:3075853 /uninstall /quiet /norestart

REM kb3080149 Telemetry 
start "title" /b /wait wusa.exe /kb:3080149 /uninstall /quiet /norestart

REM kb3081437 Windows 10 Upgrade preparation
start "title" /b /wait wusa.exe /kb:3081437 /uninstall /quiet /norestart

REM kb3081454 Windows 10 Upgrade preparation
start "title" /b /wait wusa.exe /kb:3081454 /uninstall /quiet /norestart

REM kb3081954 Adds Telemetry data points to Work Folders for Asimov telemetry pipeline in Windows 7 SP1 
start "title" /b /wait wusa.exe /kb:3081954 /uninstall /quiet /norestart

REM kb3083324 Telemetry Windows 7 - Windows 10 Upgrade preparation for Windows 7 
start "title" /b /wait wusa.exe /kb:3083324 /uninstall /quiet /norestart

REM kb3083325 Telemetry Windows 8.1 - Windows 10 Upgrade preparation for Windows 8
start "title" /b /wait wusa.exe /kb:3083325 /uninstall /quiet /norestart

REM kb3088195 Microsoft Claims it's a security update but has a key logger on the Kernel Level
start "title" /b /wait wusa.exe /kb:3088195 /uninstall /quiet /norestart

REM kb3090045 Windows 10 Upgrade Update for Windows 7/8
start "title" /b /wait wusa.exe /kb:3090045 /uninstall /quiet /norestart

REM kb3093983 Microsoft claims it's a security update but it contains IE spying
start "title" /b /wait wusa.exe /kb:3093983 /uninstall /quiet /norestart

REM kb3112336 Enables additional upgrade scenarios from Windows 8.1 to Windows 10
start "title" /b /wait wusa.exe /kb:3112336 /uninstall /quiet /norestart

REM kb3112343 Enables additional upgrade scenarios from Windows 7 to Windows 10
start "title" /b /wait wusa.exe /kb:3112343 /uninstall /quiet /norestart
REM - Done.
timeout 3

REM --- Now Hiding Updates, be patient...

start "title" /b /wait cscript.exe "%~dp0HideUpdates.vbs" 971033 2902907 2922324 2952664 2976978 2977759 2990214 3012973 3014460 3015249 3021917 3022345 3035583 3042058 3044374 3050265 3064683 3065987 3065988 3068707 3068708 3072318 3074677 3075249 3075853 3080149 3081437 3081454 3081954 3083324 3083325 3088195 3090045 3093983 3112336 3112343 

REM - Done.

REM - Now BLOCKING Windows 10 Download & Upgrade
timeout 4

:: reg hacks -------------------------------------------
REM Disable downloaded w10 files
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx /f /v DisableGwx /t REG_DWORD /d 1
REM Disable upgrade requests
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f /v DisableOSUpgrade /t REG_DWORD /d 1

REM - Disable Telemetry Tasks
timeout 4

:: scheduled tasks -------------------------------------
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Media Center\ActivateWindowsSearch" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\ConfigureInternetTimeService" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\DispatchRecoveryTasks" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\ehDRMInit" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\InstallPlayReady" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\mcupdate" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\MediaCenterRecoveryTask" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\ObjectStoreRecoveryTask" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\OCURActivate" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\OCURDiscovery" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\PBDADiscovery" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\PBDADiscoveryW1" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\PBDADiscoveryW2" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\PvrRecoveryTask" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\PvrScheduleTask" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\RegisterSearch" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\ReindexSearchRoot" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\SqlLiteRecoveryTask" /DISABLE

schtasks /Change /TN "\Microsoft\Windows\Media Center\UpdateRecordPath" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\launchtrayprocess" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfig" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfigandcontent" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxcontent" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE



REM - Killing Diagtrack-service (if it still exists)...
sc stop Diagtrack
sc delete Diagtrack
REM - Done.

REM - Stop remoteregistry-service (if it still exists)...
sc stop remoteregistry
sc config remoteregistry start= disabled

REM - FINISHED! Manually Reboot for changes to take the effect

pause

)