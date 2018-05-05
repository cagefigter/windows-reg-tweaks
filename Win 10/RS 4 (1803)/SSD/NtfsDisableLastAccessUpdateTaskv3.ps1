If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -WindowStyle Hidden -Verb runAs -ArgumentList $arguments
Break
}
#######################    Variables     #######################

$taskname = "Update FileSystem"
$Path = 'WScript.exe'
$File = Join-Path $env:PUBLIC -ChildPath "\NtfsDisableLastAccessUpdate.vbs"
$SetVbsFile = 
'If WScript.Arguments.length = 0 Then 
Set objShell = CreateObject("Shell.Application") 
objShell.ShellExecute "WScript.exe", Chr(34) & _ 
WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
Set objShell=CreateObject("WScript.Shell") 
ps1 = "Set-ItemProperty -Path ''HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'' -Name ''NtfsDisableLastAccessUpdate'' -Value ''1''"
PS = "Powershell.exe -NoProfile -NonInteractive -Nologo -command " & Chr(34) & "& {" & ps1 & "}" & Chr(34)
objShell.Run PS,0
End If'

#######################    Set environment     #######################

#Create the launch file
if (Test-Path($File)) { Remove-Item $File -Force }
New-Item $File -ItemType File -Value $SetVbsFile | Out-Null

Get-ScheduledTask -TaskName $taskname -ErrorAction SilentlyContinue |  Unregister-ScheduledTask -Confirm:$false 

#######################  Create the Task     #######################

$Service = New-Object -ComObject Schedule.Service
$Service.Connect()

$RootFolder = $Service.GetFolder("\")

$TaskDefinition = $Service.NewTask(0)
$TaskDefinition.RegistrationInfo.Description = 'Force NtfsDisableLastAccessUpdate'
$TaskDefinition.Principal.UserId = "SYSTEM"
$TaskDefinition.Settings.Enabled = $true
$TaskDefinition.Settings.AllowDemandStart = $true
$TaskDefinition.Settings.DisallowStartIfOnBatteries = $false
$TaskDefinition.Settings.Compatibility = 2

$Triggers = $TaskDefinition.Triggers
$TriggerLogOn = $Triggers.Create(9) 
$TriggerLogOn.Enabled = $true
$TriggerEvent = $Triggers.Create(0) 
$TriggerEvent.Subscription = "<QueryList><Query Id='0' Path='System'><Select Path='System'>*[System[Provider[@Name='Microsoft-Windows-Ntfs'] and EventID=98]]</Select></Query></QueryList>"
$TriggerEvent.Enabled = $true

$Action = $TaskDefinition.Actions.Create(0)
$Action.Path = $Path
$Action.Arguments = $File

$RootFolder.RegisterTaskDefinition($taskname, $TaskDefinition, 6, $null, $null, 0) | Out-Null

