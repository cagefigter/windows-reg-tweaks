'This script can be used to hide a driver if it is causing problems on your machine, you have uninstalled it, and you want to prevent Windows Update from reinstalling it
 Set updateSession = CreateObject("Microsoft.Update.Session")
 updateSession.ClientApplicationID = "MSDN Sample Script to Hide drivers"

 WScript.Echo "This script allows you to 'hide' selected drivers so Windows Update will not auto-install them" & vbCr & vbLf & _
 "This is not normally recommended, but can be used for troubleshooting or support" & vbCr & vbLf & _
 "Note: This script must be run elevated (run as admin) to work properly - else (un)hiding will fail with a cryptic error message" & vbCr & vbLf & vbLf & _
 "Searching for applicable drivers..."

 'Find all applicable drivers
 Set updateSearcher = updateSession.CreateupdateSearcher()
 Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Driver'")
 If searchResult.Updates.Count = 0 Then
 WScript.Echo "No applicable drivers..."
 WScript.Quit
 End If

 'Cycle through applicable drivers and offer to (un)hide each one
 For i = 0 To searchResult.Updates.Count-1
 Set update = searchResult.Updates.Item(i)
 currentState = "(currently not hidden)"
 If (update.IsHidden <> 0) Then
 currentState = "(currently hidden)"
 End If
 WScript.Echo "Type 'y' and then hit Enter to hide update " & update.Title & " " & currentState & ": "
 hide = WScript.StdIn.Readline
 If hide = "y" Then
 If (update.IsHidden <> 1) Then
 update.IsHidden = 1
 End If
 Else
 If (update.IsHidden <> 0) Then
 update.IsHidden = 0
 End If
 End If 
 Next
