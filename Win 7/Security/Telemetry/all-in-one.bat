REM keeping win7 clean !!!! (change this file CleanWin7.txt extension to cmd and run)

:: reg hacks -------------------------------------------
REM disable downloaded w10 files
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx /f /v DisableGwx /t REG_DWORD /d 1
REM disable upgrade requests
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f /v DisableOSUpgrade /t REG_DWORD /d 1

:: services ---------------------------------------------
sc config DiagTrack start= disabled
net stop DiagTrack

:: scheduled tasks reporting to Redmond -----------
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement ProgramKernelCeipTask\" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Autochk\Media Center\*all*" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\launchtrayprocess" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfig" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfigandcontent" /DISABLE
REM schtasks /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxcontent" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE

:: evil updates -----------------------------------------

REM kb971033  License validation check
start "title" /b /wait wusa.exe /kb:971033 /uninstall /quiet /norestart

REM kb2876229 Skype 
start "title" /b /wait wusa.exe /kb:2876229 /uninstall /quiet /norestart

REM kb2952664 Compatibility update for upgrading Windows 7
start "title" /b /wait wusa.exe /kb:2952664 /uninstall /quiet /norestart

REM kb2976978 Compatibility update for Windows 8.1 and Windows 8
start "title" /b /wait wusa.exe /kb:2976978 /uninstall /quiet /norestart

REM kb2977759 - W10 Diagnostics Compatibility telemetry
start "title" /b /wait wusa.exe /kb:2977759 /uninstall /quiet /norestart

REM kb2990214 Update that enables you to upgrade from Windows 7 to a later version of Windows
start "title" /b /wait wusa.exe /kb:2990214 /uninstall /quiet /norestart

REM kb3012973 Upgrade to Windows 10 Pro
start "title" /b /wait wusa.exe /kb:3012973 /uninstall /quiet /norestart

REM kb3021917 Update to Windows 7 SP1 for performance improvements
start "title" /b /wait wusa.exe /kb:3021917 /uninstall /quiet /norestart

REM kb3022345 Update for customer experience and diagnostic telemetry (replace with KB3068708)
start "title" /b /wait wusa.exe /kb:3022345 /uninstall /quiet /norestart

REM kb3035583 Update installs get windows 10 app in Windows 8.1 and Windows 7 SP1
start "title" /b /wait wusa.exe /kb:3035583 /uninstall /quiet /norestart

REM kb3044374 - W8,8.1 Nagware for W10
start "title" /b /wait wusa.exe /kb:3044374 /uninstall /quiet /norestart

REM kb3050265 - Windows Update service updated to accept upgrade to W10
start "title" /b /wait wusa.exe /kb:3050265 /uninstall /quiet /norestart

REM kb3065987 - update for Windows Update (v7 v2008)
start "title" /b /wait wusa.exe /kb:3065987 /uninstall /quiet /norestart

REM kb3068707 - Customer experience telemetry points
start "title" /b /wait wusa.exe /kb:3068707 /uninstall /quiet /norestart

REM kb3068708 (replaces KB3022345) Update for customer experience and diagnostic telemetry
start "title" /b /wait wusa.exe /kb:3068708 /uninstall /quiet /norestart

REM kb3075249 Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
start "title" /b /wait wusa.exe /kb:3075249 /uninstall /quiet /norestart

REM kb3080149 Update for customer experience and diagnostic telemetry 
start "title" /b /wait wusa.exe /kb:3080149 /uninstall /quiet /norestart

REM Remember to *hide* all these in Windows Update