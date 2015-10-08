ECHO OFF
REM --- remember to invoke from ELEVATED command prompt!
REM --- or start the batch with context menu "run as admin".
SETLOCAL

REM --- (as of 2015-08-26):
REM  KB3012973 - Upgrade to Windows 10 Pro
REM  KB3021917 - Update to Windows 7 SP1 for performance improvements
REM  KB3035583 - GWX Update installs Get Windows 10 app in Windows 8.1 and Windows 7 SP1
REM  KB2952664 - Compatibility update for upgrading Windows 7
REM  KB2976978 - Compatibility update for Windows 8.1 and Windows 8
REM  KB3022345 - Telemetry [Replaced by KB3068708]
REM  KB3068708 - Update for customer experience and diagnostic telemetry
REM  KB2990214 - Update that enables you to upgrade from Windows 7 to a later version of Windows
REM  KB3075249 - Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
REM  KB3080149 - Update for customer experience and diagnostic telemetry
REM  KB3044374 - W8,8.1 Nagware for W10
REM  KB2977759 - W10 Diagnostics Compatibility Telemetry
REM  KB3050265 - Windwos Update services update to upgrade to W10
REM  KB3068707 - Customer experience telemetry point. W7,8,8.1


REM --- uninstall updates
echo uninstalling updates ...
start "title" /b /wait wusa.exe /kb:3012973 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3021917 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3035583 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:2952664 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:2976978 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3022345 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3068708 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:2990214 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3075249 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3080149 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3044374 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:2977759 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3050265 /uninstall /quiet /norestart
echo  - done.
start "title" /b /wait wusa.exe /kb:3068707 /uninstall /quiet /norestart
echo  - done.

timeout 10

echo ... COMPLETED (please remember to REBOOT, and Hide the Following KB Updates)
echo ...3012973
echo ...3021917
echo ...3035583
echo ...2952664
echo ...2976978
echo ...3022345
echo ...3068708
echo ...2990214
echo ...3075249
echo ...3080149
echo ...3044374
echo ...2977759
echo ...3050265
echo ...3068707
echo  - done.


pause
REM --- EOF