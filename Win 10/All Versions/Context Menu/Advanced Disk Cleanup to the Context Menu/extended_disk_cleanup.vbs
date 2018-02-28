' Save as extended_disk_cleanup.vbs file
' Copy the following .vbs and .reg files to C:\Windows and run the .reg file to add the extended disk cleanup option to the context menu.

If WScript.Arguments.length =0 Then
  Set Brink1 = CreateObject("Shell.Application")
  Brink1.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " Run", , "runas", 1
Else
   Set Brink2 = WScript.CreateObject("WSCript.shell")
   Brink2.run ("cmd.exe /c cleanmgr /sageset:65535 & cleanmgr /sagerun:65535"), 0
End If