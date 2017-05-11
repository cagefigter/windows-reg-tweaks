' RecoverNoScript.vbs
'
' Version 1.0

' SYNOPSIS
'	Copies the NoScript whitelist from the (default) sandboxed Firefox prefs.js file and replaces
'	the same line in the non-sandboxed Firefox prefs.js file

'	Checks that Firefox is closed before starting
'	Checks for the presence of a sandboxed default profile folder and prefs.js file before starting
'	Checks for the presence of a non-sandboxed default profile folder and prefs.js file before starting
'	Creates a backup file prefs-bak.js in the Firefox default profile folder
'	Extracts the name of the default profile folder from the file system
'
' USAGE
' 1) 	Run Firefox in default sandbox
'		[Firefox makes changes to the NoScript whitelist -Optional]
'		Exit Firefox
'		Run this script
'
' OR
'		
' 2)	Run this script, and click OK to the pop-up (Ignore pop-up to cancel whitelist recovery)
'		Run Firefox in default sandbox
'		[Firefox makes changes to the NoScript whitelist -Optional]
'		Exit Firefox
'		Run this script

Const ForReading=1
Const ForWriting=2
Const OverWriteFile = True

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objNetwork = wscript.CreateObject("wscript.network")
Set objShell = CreateObject("Wscript.Shell")

userName = objNetwork.Username

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
	
Set colOperatingSystems = objWMIService.ExecQuery _
    ("Select * from Win32_OperatingSystem")
For Each objOperatingSystem in colOperatingSystems
     'Wscript.Echo "Caption: " & objOperatingSystem.Caption 'Microsoft Windows 7 Professional
	If Instr(1,objOperatingSystem.Caption,"Microsoft Windows 7",1) = False Then
		WScript.Echo "Error: This script is only tested on Microsoft Windows 7.  This OS is " & objOperatingSystem.Caption
		WScript.Quit (1)
	End If
Next	

ProfilesFolderPath   = "C:\Users\" & userName & "\AppData\Roaming\Mozilla\Firefox\Profiles\"
'WScript.Echo "ProfilesFolderPath is " & ProfilesFolderPath

ProfilesFolderPathSB = "C:\Sandbox\" & userName & "\DefaultBox\user\current\AppData\Roaming\Mozilla\Firefox\Profiles\"
'WScript.Echo "ProfilesFolderPathSB is " & ProfilesFolderPathSB

If objFSO.FolderExists(ProfilesFolderPath) Then
	'WScript.Echo "Found Firefox profiles folder at " & ProfilesFolderPath
Else
	WScript.Echo "Error: Firefox profiles folder " & ProfilesFolderPath & " was not found."
	WScript.Quit (1)
End If
If objFSO.FolderExists(ProfilesFolderPathSB) Then
	'WScript.Echo "Found Sandboxed Firefox profiles folder at " & ProfilesFolderPathSB
Else
	WScript.Echo "Error: Sandboxed Firefox profiles folder " & ProfilesFolderPathSB & " was not found.  Start FF in SB first."
	WScript.Quit (1)
End If

' search for subfolder with .default suffix
foundDefaultProfileFolder = False
For Each subf In objFSO.GetFolder(ProfilesFolderPath).SubFolders
	'WScript.Echo "Sub-folder is " & subf
	If Instr(1,subf,".default",1) Then
		foundDefaultProfileFolder = True
		defaultProfileFolder = subf
		'WScript.Echo "defaultProfileFolder is " & defaultProfileFolder
		Exit For
	End If
Next
If 	foundDefaultProfileFolder = False Then
	WScript.Echo "Error: Default profile sub-folder was not found at " & folderPath
	WScript.Quit (1)
End If
' search for subfolder with .default suffix        -SANDBOXED
foundDefaultProfileFolder = False
For Each subf In objFSO.GetFolder(ProfilesFolderPathSB).SubFolders
	'WScript.Echo "Sub-folder(SB) is " & subf
	If Instr(1,subf,".default",1) Then
		foundDefaultProfileFolder = True
		defaultProfileFolderSB = subf
		'WScript.Echo "defaultProfileFolderSB is " & defaultProfileFolderSB
		Exit For
	End If
Next
If 	foundDefaultProfileFolder = False Then
	WScript.Echo "Error: Sandboxed default profile sub-folder(SB) was not found at " & ProfilesFolderPathSB
	WScript.Quit (1)
End If

Function isProcessRunning( processName )
	isProcessRunning = False
	Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process")
	For Each objProcess in colProcessList
		'WScript.Echo "objProcess.Name = " & objProcess.Name
		If objProcess.Name = processName Then
		isProcessRunning = True
		Exit For
		End If
	Next
End Function

If isProcessRunning( "firefox.exe" ) = True Then
	nsecstowait = 5
	intButton = objShell.Popup( "Press OK in " & nsecstowait & " seconds to schedule recovery of NoScript whitelist when Firefox closes", nsecstowait, "", vbOKCancel + vbQuestion + vbSystemModal)
	
	If intButton = 2 Then
		objShell.Popup "NoScript whitelist recovery was canceled", 2, "", vbOKCancel + vbQuestion + vbSystemModal
		WScript.quit
	End If
	If intButton = 1 Then
		objShell.Popup "NoScript whitelist recovery was scheduled",2,"Information", vbOKCancel + vbQuestion + vbSystemModal
	Else
		objShell.Popup "NoScript whitelist recovery was canceled",2,"Information", vbOKCancel + vbQuestion + vbSystemModal
		WScript.quit
	End If
End If
	

REM Sub waitForProcess( processName )
	REM Do While isProcessRunning( processName ) = False
		REM WScript.Sleep 2000
	REM Loop
	REM 'WScript.Echo "waitForProcess: Found Process " & processName
REM End Sub

Sub waitForProcessStop( processName )
	Do While isProcessRunning( processName ) = True
		WScript.Sleep 2000
	Loop
	'objShell.Popup "Debug:  waitForProcessStop: Process " & processName & " is not running.",3,"Information", vbOKCancel + vbQuestion + vbSystemModal

End Sub

waitForProcessStop "firefox.exe"

prefsFile     = defaultProfileFolder & "\" & "prefs.js"
prefsFileBak  = defaultProfileFolder & "\" & "prefs-bak.js"
prefsFileTemp = defaultProfileFolder & "\" & "prefs-temp.js"
prefsFileSB   = defaultProfileFolderSB & "\" & "prefs.js"
'WScript.Echo "prefsFile is " & prefsFile
'WScript.Echo "prefsFileBak is " & prefsFileBak
'WScript.Echo "prefsFileTemp is " & prefsFileTemp
'WScript.Echo "prefsFileSB is " & prefsFileSB

If Not objFSO.FileExists(prefsFileSB) Then
	WScript.Echo "Error:  Firefox preferences file, prefs.js was not found in the default sandbox"
	Set objFSO = Nothing
	WScript.Quit(1)
'Else
	'WScript.Echo "Found Firefox preferences file, prefs.js file in default sandbox"
End If

If Not objFSO.FileExists(prefsFile) Then
	WScript.Echo "Error:  Did not find Firefox preferences file, prefs.js"
	Set objFSO = Nothing
	WScript.Quit(1)
'Else
	'WScript.Echo "Found Firefox preferences file, prefs.js"
End If

Set prefsFileObj     = objFSO.OpenTextFile(prefsFile,     ForReading, True)
Set prefsFileTempObj = objFSO.OpenTextFile(prefsFileTemp, ForWriting, True)
Set prefsFileSBObj   = objFSO.OpenTextFile(prefsFileSB,   ForReading, True)

objFSO.CopyFile prefsFile, prefsFileBak, OverWriteFile

'	Find the line with the NoScript whitelist from the sandboxed prefs.js file
Do While Not prefsFileSBObj.AtEndofStream
	myLine = prefsFileSBObj.ReadLine
	If InStr(myLine, "capability.policy.maonoscript.sites") Then
		noScriptLine = myLine
	End If
Loop
'WScript.Echo "noScriptLine is " & noScriptLine
prefsFileSBObj.Close

'	Copy the non-sandboxed prefs.js file line-by-line to prefsFileTempObj
'		-except for the line with the NoScript whitelist
'			- substitute noScriptLine for that line 
Do While Not prefsFileObj.AtEndofStream
	myLine = prefsFileObj.ReadLine
	If InStr(myLine, "capability.policy.maonoscript.sites") Then
		myLine = noScriptLine
	End If
	prefsFileTempObj.WriteLine myLine
Loop

prefsFileTempObj.Close
prefsFileObj.Close

objFSO.CopyFile prefsFileTemp, prefsFile, OverWriteFile
objFSO.DeleteFile(prefsFileTemp)

objShell.Popup "NoScript whitelist was recovered from Sandbox",3,"Information", vbOKCancel + vbQuestion + vbSystemModal
WScript.Quit (0)
