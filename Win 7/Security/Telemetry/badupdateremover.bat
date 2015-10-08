@echo off

if %1. == . goto usage

set UNINSTALLX=uninstall-%1-updates.cmd
set HIDEX=hide-%1-updates.ps
set BADUPDATES=

echo %1
if %1 == win7     set BADUPDATES=971033 2952664 2977759 2990214 3021917 3022345 3035583 3050265 3065987 3068708 3075249 3080149
if %1 == win81    set BADUPDATES=2976978 3022345 3035583 3044374 3050267 3068708 3075249 3075853 3080149
if %1 == w2008r2  set BADUPDATES=3022345 3050265 3065987 3068708 3080149
if %1 == w2012r2  set BADUPDATES=3022345 3068708 3075853 3080140
if not defined BADUPDATES goto usage

echo %BADUPDATES%
if exist %UNINSTALLX% del %UNINSTALLX%
if exist %HIDEX%      del %HIDEX%
for %%n in (%BADUPDATES%) do (
	echo start /w wusa.exe /uninstall /kb:%%n /norestart                        >> %UNINSTALLX%
	echo Hide-WUUpdate -Confirm:$false -HideStatus:$true -KBArticleID KB%%n     >> %HIDEX%
)
goto end

:usage
echo Okay, you didn't give the right parameter... it needs to be win7, win81, w2008r2 or w2012r2

:end
echo.