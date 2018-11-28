@echo off
@start /b "Remove Defender as TrustedInstaller" "%~dp0Bin\NSudo.exe" -U:T -P:E "%~dp0Bin\removal.cmd"