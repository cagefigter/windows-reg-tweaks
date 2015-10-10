@echo off

REM original findings by https://twitter.com/thisisdey/status/628914599706914816

echo Adobe Flash Removal
echo.
echo This will remove the baked-in Adobe Flash from Windows 10.
echo Run this script as admin.
echo.
pause

takeown /f "%windir%\System32\Macromed" /r /d y
icacls "%windir%\System32\Macromed" /grant administrators:F /t
rd /s /q "%windir%\System32\Macromed"
echo.

takeown /f "%windir%\SysWOW64\Macromed" /r /d y
icacls "%windir%\SysWOW64\Macromed" /grant administrators:F /t
rd /s /q "%windir%\SysWOW64\Macromed"
echo.

rd /s /q "%appdata%\Adobe"
rd /s /q "%appdata%\Macromedia"
echo.

pause