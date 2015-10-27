1) Start Powershell as admin
2) Get-AppxPackage Microsoft.MicrosoftEdge_20.10240.16384.0_neutral__8wekyb3d8bbwe | Remove-AppxPackage
3) Alternative for step 2 -> Get-AppxPackage  *edge* | Remove-AppxPackage
4) Navigate C:\Windows\SystemApps\, now click on the Microsoft.MicrosoftEdge_8wekyb3d8bbwe folder and mark it as read-only. 


It's not recommed to do this because it's one of Windows 10 core components which possible breaks other stuff too.