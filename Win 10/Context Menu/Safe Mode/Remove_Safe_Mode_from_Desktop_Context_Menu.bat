@echo off

Reg Delete "HKCR\DesktopBackground\Shell\SafeMode" /F
Reg Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NormalMode" /F
Reg Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SafeMode" /F
Reg Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SafeModeNetworking" /F
Reg Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SafeModeCommandPrompt" /F

If exist "%windir%\Safe_Mode" RD /S /Q "%windir%\Safe_Mode"


