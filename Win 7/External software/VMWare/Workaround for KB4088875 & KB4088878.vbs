' Source: https://support.microsoft.com/en-us/help/3125574/convenience-rollup-update-for-windows-7-sp1-and-windows-server-2008-r2
' Article: https://chefkochblog.wordpress.com/2018/03/19/workaround-for-kb4088875-kb4088878/
' You might need to restart twice after apply this workaround script. Before you apply it ensure you make a HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\PCI backup manually!
' 

Option Explicit
Const HKEY_LOCAL_MACHINE = &H80000002
Dim oReg : Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
Dim oShell : Set oShell = CreateObject("WScript.Shell")
Dim sPath, aSub, sKey, aSubToo, sKeyToo, dwValue, Result, SaveResult
Dim NotDeleted
 
NotDeleted = 0
 
' Get all keys within sPath
sPath = "SYSTEM\CurrentControlSet\Enum\PCI"
oReg.EnumKey HKEY_LOCAL_MACHINE, sPath, aSub
 
' Loop through each key
For Each sKey In aSub
    ' Get all subkeys within the key 'sKey'
    oReg.EnumKey HKEY_LOCAL_MACHINE, sPath & "\" & sKey, aSubToo
    For Each sKeyToo In aSubToo
      Result = oReg.DeleteKey(HKEY_LOCAL_MACHINE, sPath & "\" & sKey & "\" & sKeyToo & "\" & "\Device Parameters" & "\SlotPersistentInfo")
      ' Allow failure only if key never existed
      If (Result = 1) Or (Result > 2) Then
        NotDeleted = 1
        SaveResult = Result
      End If
    Next
Next
 
If (NotDeleted > 0) Then 
  Wscript.Echo "One or more SlotPersistentInfo keys still exist under HKLM\System\CurrentControlSet\Enum\PCI\<deviceid>\<subdeviceid>\Device Parameters.  Please delete manually. Result = " & Result
End If 