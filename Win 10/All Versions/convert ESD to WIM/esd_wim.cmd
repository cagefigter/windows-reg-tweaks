goto="init" /* %~nx0
::----------------------------------------------------------------------------------------------------------------------------------
:about
::----------------------------------------------------------------------------------------------------------------------------------
title Windows Update ESD to WIM Setup for x86 or x64
color 1f
pushd "%~dp0"
for /f %%s in ('dir /b *.esd ^| find ".esd"') do set "ESD=%%~fs"
if not exist "%ESD%" echo [ERROR] No .esd source file found in %~dp0 &pause &exit
exit/b
::----------------------------------------------------------------------------------------------------------------------------------
:main [ Batch main function ]
::----------------------------------------------------------------------------------------------------------------------------------
call :about &timeout /t 10 &echo.
echo Processing.. %ESD%
( del /f/s/q ISOFiles &rmdir /s/q ISOFiles ) >nul 2>nul
 
set "s10=$ESDFilePath=Get-ChildItem *.esd; $ImageExclusions=@('Windows Setup Media', 'Microsoft Windows PE (x64)',"
set "s11= 'Microsoft Windows Setup (x64)', 'Microsoft Windows PE (x86)', 'Microsoft Windows Setup (x86)');"
set "s12=$AllImages=Get-WindowsImage -ImagePath $ESDFilePath; write-host $AllImages.ImageName;"
set "s13=$SetupMediaImage=$AllImages.Where({$_.ImageName -eq "Windows Setup Media"});"
set "s14=$SetupImage=$AllImages.Where({$_.ImageName -eq "Microsoft Windows Setup (x64)" -or"
set "s15= $_.ImageName -eq "Microsoft Windows Setup (x86)"});"
set "s16=New-Item -Path ".\ISOFiles" -ItemType Directory -ErrorAction SilentlyContinue;"
set "s17=Expand-WindowsImage -ImagePath $ESDFilePath -Index $SetupMediaImage.ImageIndex -ApplyPath ".\ISOFiles";"
set "s18=Export-WindowsImage -SourceImagePath $ESDFilePath -SourceIndex $SetupImage.ImageIndex -CompressionType Maximum"
set "s19= -DestinationImagePath ".\ISOFiles\Sources\boot.wim" -DestinationName $SetupImage.ImageName;"
set "s20=$AllImages.Where({$_.ImageName -notin $ImageExclusions}).foreach( {"
set "s21=  Export-WindowsImage -SourceImagePath $ESDFilePath -SourceIndex $_.ImageIndex -CompressionType Maximum"
set "s22= -DestinationImagePath ".\ISOFiles\Sources\Install.wim" -DestinationName $_.ImageName } );"
 
for /l %%# in (10,1,22) do call set "ps_esd2wim=%%ps_esd2wim%%%%s%%#:"=\"%%"
powershell.exe -c "%ps_esd2wim%;"
pause
exit
 
::----------------------------------------------------------------------------------------------------------------------------------
:"init" [ Batch entry function ]
::----------------------------------------------------------------------------------------------------------------------------------
@echo off & cls & setlocal & if "%1"=="init" shift &shift & goto :main &rem Admin self-restart flag found, jump to main
reg query "HKEY_USERS\S-1-5-20\Environment" /v temp 1>nul 2>nul && goto :main || call :about & echo  Requesting admin rights..
call cscript /nologo /e:JScript "%~f0" get_rights "%1" & exit
::----------------------------------------------------------------------------------------------------------------------------------
*/ // [ JScript functions ] all batch lines above are treated as a /* js comment */ in cscript
function get_rights(fn) { var console_init_shift='/c start "init" "'+fn+'"'+' init '+fn+' '+WSH.Arguments(1);
  WSH.CreateObject("Shell.Application").ShellExecute('cmd.exe',console_init_shift,"","runas",1); }
if (WSH.Arguments.length>=1 && WSH.Arguments(0)=="get_rights") get_rights(WSH.ScriptFullName);
//