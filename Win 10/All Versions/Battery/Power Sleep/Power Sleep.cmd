@echo off &mode 32,2 &color cf &title Power Sleep
set "s1=$m='[DllImport ("Powrprof.dll", SetLastError = true)]"
set "s2=static extern bool SetSuspendState(bool hibernate, bool forceCritical, bool disableWakeEvent);"
set "s3=public static void PowerSleep(){ SetSuspendState(false, false, false); }';"
set "s4=add-type -name Import -member $m -namespace Dll; [Dll.Import]::PowerSleep();"
set "ps_powersleep=%s1%%s2%%s3%%s4%"
call powershell.exe -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass -Command "%ps_powersleep:"=\"%"
exit