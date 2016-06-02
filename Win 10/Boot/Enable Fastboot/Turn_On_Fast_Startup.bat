@echo off

:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power

:: HiberbootEnabled DWORD
:: 0 = Turn off fast startup
:: 1 = Turn on fast startup



:: To enable hibernate
powercfg -h on


:: To turn on Fast Startup
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 1 /F



