<# ||||| Windows 10 Enterprise N LTSB ~debloat~ V1.0 ||||| #>
<# Prerequisites:
    - Clean Windows installation

    - Internet connection

    - Execute this from an elevated Powershell Console
    - You have to manually allow scripts to run (one time only) so execute this command:
      Set-ExecutionPolicy RemoteSigned

    - This is important, you have to wait for the OneDrive installation after your first Windows login
    - it might take 5 minutes to pop up but you have to wait for it to install completely so we can nuke it
#>
$settings = $true # Set to false to disable editing settings
$hosts = $true # Set to false to disable editing hosts file
$localpolicy = $true # Set to false to disable editing local policy
$registry = $true # Set to false to disable editing registry
$features = $true # Set to false to disable removing features
$services = $true # Set to false to disable removing services
$schdtasks = $true # Set to false to disable OOTB scheduled tasks

# Disable scheduled tasks
if ($schdtasks -eq $true)
{
    Write-Progress -Activity "Disabling scheduled tasks" -Status "Progress:" -PercentComplete 0
    schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable | out-null
    schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable | out-null
    Write-Progress -Activity "Disabling scheduled tasks" -Status "Progress:" -PercentComplete 4
}
# Disable services
if ($services -eq $true)
{
    Write-Progress -Activity "Disabling services" -Status "Progress:" -PercentComplete 4
    # Disable DiagTrack
    cmd /c sc config DiagTrack start= disabled | out-null
    cmd /c sc config dmwappushservice start= disabled | out-null
    cmd /c sc config diagnosticshub.standardcollector.service start= disabled | out-null
    cmd /c sc config TrkWks start= disabled | out-null
    cmd /c sc config HomeGroupProvider start= disabled | out-null
    cmd /c sc config WMPNetworkSvc start= disabled | out-null # Shouldn't exist but just making sure ...
    # Making sure the DiagTrack log is empty (tinfoil)
    Set-Content C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl -Value "" -Force
    Write-Progress -Activity "Disabling services" -Status "Progress:" -PercentComplete 7
}
# Tweak settings app
if ($settings -eq $true)
{
    Write-Progress -Activity "Backing up registry" -Status "Progress:" -PercentComplete 10 # Let's be save
    if (!(test-path -PathType Leaf C:\registry-backup-hklm.reg)) { reg export HKLM C:\registry-backup-hklm.reg | Out-Null }
    if (!(test-path -PathType Leaf C:\registry-backup-hkcu.reg)) { reg export HKCU C:\registry-backup-hkcu.reg | Out-Null }
    if (!(test-path -PathType Leaf C:\registry-backup-hkcr.reg)) { reg export HKCR C:\registry-backup-hkcr.reg | Out-Null }

    Write-Progress -Activity "Tweaking settings app" -Status "Progress:" -PercentComplete 12
    # Privacy -> General -> let websites provide locally relevant content by accessing my language list
    if ((Get-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Internet Explorer\International\" -Name AcceptLanguage -ErrorAction SilentlyContinue) -ne $null) { Remove-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Internet Explorer\International" -Name "AcceptLanguage" -Force }
    Set-ItemProperty -Path "HKCU:Control Panel\International\User Profile" -Name HttpAcceptLanguageOptOut -Value 1 | Out-Null
    # Privacy -> General -> turn on smartscreen filter to check web content that windows store apps use
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost\" -Name EnableWebContentEvaluation -Value 0 -Force | Out-Null
    # Privacy -> Camera -> let apps use my camera
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Microphone -> let apps use my microphone
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Account info -> let apps access my name, picture and other account info
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Calendar -> let apps access my calendar
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Messaging -> let apps read or send sms and text messages
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Radio -> let apps control radios
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Other devices -> sync with devices
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled\" -Name Value -Value "Deny" | Out-Null
    # Privacy -> Feedback & Diagnostics -> feedback frequency
    New-Item -Path "HKCU:SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Siuf\Rules" -Name NumberOfSIUFInPeriod -Value 0 -Force | Out-Null
    if ((Get-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Siuf\Rules" -Name PeriodInNanoSeconds -ErrorAction SilentlyContinue) -ne $null) { Remove-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Siuf\Rules" -Name PeriodInNanoSeconds }
    # Ease of Access -> Other options -> Visual options -> play animations
    Set-ItemProperty -Path "HKCU:Control Panel\Desktop\WindowMetrics" -Name MinAnimate -Value 0 | Out-Null
    Write-Progress -Activity "Tweaking settings app" -Status "Progress:" -PercentComplete 15
}
# Append hosts file entries
if ($hosts -eq $true)
{
    Write-Progress -Activity "Appending entries to hosts file" -Status "Progress:" -PercentComplete 15
    $file = "C:\Windows\System32\drivers\etc\hosts"
    
    "127.0.0.1 vortex.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-win.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 redir.metaservices.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 reports.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 services.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.ppe.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.urs.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net:443" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 settings-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-win.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 redir.metaservices.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 settings-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 reports.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.ppe.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.urs.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 survey.watson.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.live.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 services.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-win.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telecommand.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 oca.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.telemetry.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 redir.metaservices.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 choice.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 reports.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 services.wes.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sqm.df.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.ppe.telemetry.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.urs.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 telemetry.appex.bing.net:443" | Out-File -encoding ASCII -append $file
    "127.0.0.1 settings-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 vortex-sandbox.data.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 survey.watson.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.live.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 watson.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 statsfe2.ws.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 corpext.msitadfs.glbdns2.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 compatexchange.cloudapp.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 cs1.wpc.v0cdn.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0001.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0002.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0003.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0004.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0005.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0006.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0007.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0008.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-0009.a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 a-msedge.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 statsfe2.update.microsoft.com.akadns.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 sls.update.microsoft.com.akadns.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 fe2.update.microsoft.com.akadns.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 diagnostics.support.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 corp.sts.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 statsfe1.ws.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 pre.footprintpredict.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 i1.services.social.microsoft.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 i1.services.social.microsoft.com.nsatc.net" | Out-File -encoding ASCII -append $file
    "127.0.0.1 feedback.windows.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 feedback.microsoft-hohm.com" | Out-File -encoding ASCII -append $file
    "127.0.0.1 feedback.search.microsoft.com" | Out-File -encoding ASCII -append $file

    Write-Progress -Activity "Appending entries to hosts file" -Status "Progress:" -PercentComplete 30
}
# Secure local group policy for privacy
# We'll need the PolicyFileEditor module for this
if ($localpolicy -eq $true)
{
    Write-Progress -Activity "Securing local group policy for privacy (this might take a minute or two)" -Status "Progress:" -PercentComplete 30
    Write-Host "Please accept the download for NuGet by pressing Y when the prompt appears in a moment:" -ForegroundColor Red
    if ((Get-Command Set-PolicyFileEntry -ErrorAction SilentlyContinue) -eq $null) # Don't have the module, download it
    {
        install-module PolicyFileEditor -Force -Confirm:$true
        Start-Sleep 5
    }
    Write-Progress -Activity "Securing local group policy for privacy" -Status "Progress:" -PercentComplete 35
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -ValueName AllowTelemetry -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" -ValueName TurnOffSidebar -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" -ValueName NoActiveHelp -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Biometrics" -ValueName Enabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Conferencing" -ValueName NoRDS -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\InputPersonalization" -ValueName AllowInputPersonalization -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Internet Explorer\Geolocation" -ValueName PolicyDisableGeolocation -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" -ValueName NoUpdateCheck -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -ValueName DoNotTrack -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Internet Explorer\Privacy" -ValueName EnableInPrivateBrowsing -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" -ValueName DisableCustomerImprovementProgram -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Messenger\Client" -ValueName CEIP -Type DWord -Data 2
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Messenger\Client" -ValueName PreventAutoRun -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -ValueName Cookies -Type DWord -Data 2
    Start-Sleep 1
    Write-Progress -Activity "Securing local group policy for privacy (this might take a minute or two)" -Status "Progress:" -PercentComplete 40
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" -ValueName DoReport -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" -ValueName ForceQueueMode -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" -ValueName DWFileTreeRoot -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" -ValueName DWNoExternalURL -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" -ValueName DWNoFileCollection -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" -ValueName DWNoSecondLevelCollection -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" -ValueName DWReporteeName -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\SearchCompanion" -ValueName DisableContentFileUpdates -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\SQMClient\Windows" -ValueName CEIPEnable -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows Defender" -ValueName DisableAntiSpyware -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -ValueName **del.SpynetReporting -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -ValueName SubmitSamplesConsent -Type DWord -Data 2
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0080000000F0000F0D0B4EB5D3C24F17D10AE531C7DCEF4A94F4A085AD0D4C88B75082573E36F857A" -ValueName Category -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0080000000F0000F0D0B4EB5D3C24F17D10AE531C7DCEF4A94F4A085AD0D4C88B75082573E36F857A" -ValueName CategoryReadOnly -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" -ValueName NoGenTicket -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows NT\IIS" -ValueName PreventIISInstall -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows NT\Printers" -ValueName PhysicalLocation -Type String -Data anonymous
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -ValueName DisabledByGroupPolicy -Type DWord -Data 1
    Start-Sleep 1
    Write-Progress -Activity "Securing local group policy for privacy (this might take a minute or two)" -Status "Progress:" -PercentComplete 50
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\AppCompat" -ValueName AITEnable -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\AppCompat" -ValueName DisableInventory -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\AppCompat" -ValueName DisableUAR -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -ValueName PreventDeviceMetadataFromNetwork -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" -ValueName DisableSendGenericDriverNotFoundToWER -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" -ValueName DisableSendRequestAdditionalSoftwareToWER -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Explorer" -ValueName NoUseStoreOpenWith -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\GameUX" -ValueName DownloadGameInfo -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\GameUX" -ValueName GameUpdateOptions -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\GameUX" -ValueName ListRecentlyPlayed -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard" -ValueName ExitOnMSICW -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -ValueName DisableLocation -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\OneDrive" -ValueName DisableFileSyncNGSC -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\PowerShell" -ValueName EnableScripts -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\PowerShell" -ValueName ExecutionPolicy -Type String -Data "RemoteSigned"
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -ValueName **del.EnableExperimentation -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -ValueName AllowBuildPreview -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -ValueName EnableConfigFlighting -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\System" -ValueName AsyncScriptDelay -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\System" -ValueName EnableLogonScriptDelay -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{186f47ef-626c-4670-800a-4a30756babad}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{2698178D-FDAD-40AE-9D3C-1371703ADC5B}" -ValueName **del.EnabledScenarioExecutionLevel -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{2698178D-FDAD-40AE-9D3C-1371703ADC5B}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{67144949-5132-4859-8036-a737b43825d8}" -ValueName **del.EnabledScenarioExecutionLevel -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{67144949-5132-4859-8036-a737b43825d8}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{86432a0b-3c7d-4ddf-a89c-172faa90485d}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{a7a5847a-7511-4e4e-90b1-45ad2a002f51}" -ValueName **del.EnabledScenarioExecutionLevel -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{a7a5847a-7511-4e4e-90b1-45ad2a002f51}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46ac-8BEE-B1715EC634E5}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{dc42ff48-e40d-4a60-8675-e71f7e64aa9a}" -ValueName EnabledScenarioExecutionLevel -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{dc42ff48-e40d-4a60-8675-e71f7e64aa9a}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{ecfb03d1-58ee-4cc7-a1b5-9bc6febcb915}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}" -ValueName **del.EnabledScenarioExecutionLevel -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}" -ValueName ScenarioExecutionEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -ValueName Disabled -Type DWord -Data 1
    Start-Sleep 1
    Write-Progress -Activity "Securing local group policy for privacy (this might take a minute or two)" -Status "Progress:" -PercentComplete 60
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -ValueName DontSendAdditionalData -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName AllowCortana -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName AllowSearchToUseLocation -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName ConnectedSearchPrivacy -Type DWord -Data 3
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName ConnectedSearchSafeSearch -Type DWord -Data 3
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName ConnectedSearchUseWeb -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName ConnectedSearchUseWebOverMeteredConnections -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ValueName DisableWebSearch -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DeferUpgrade -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DoNotConnectToWindowsUpdateInternetLocations -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName **del.AutomaticMaintenanceEnabled -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName **del.DetectionFrequency -Type String -Data ""
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName AUOptions -Type DWord -Data 2
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName DetectionFrequencyEnabled -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName EnableFeaturedSoftware -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName NoAutoUpdate -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName ScheduledInstallDay -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ValueName ScheduledInstallTime -Type DWord -Data 3
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "SOFTWARE\Policies\Microsoft\WMDRM" -ValueName DisableOnline -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\User\registry.pol -Key "Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName NoInstrumentation -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\User\registry.pol -Key "Software\Policies\Microsoft\Internet Explorer\Privacy" -ValueName EnableInPrivateBrowsing -Type DWord -Data 0
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\User\registry.pol -Key "Software\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" -ValueName DisableLogging -Type DWord -Data 1
    Start-Sleep 1
    Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\User\registry.pol -Key "Software\Policies\Microsoft\Windows\EdgeUI" -ValueName DisableMFUTracking -Type DWord -Data 1
    gpupdate /force | Out-Null
    Write-Progress -Activity "Securing local group policy for privacy" -Status "Progress:" -PercentComplete 70
}
# Tweak registry
if ($registry -eq $true)
{
    Write-Progress -Activity "Tweaking registry" -Status "Progress:" -PercentComplete 70
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    
    # Remove Action Center from the right
    New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name DisableNotificationCenter -PropertyType DWORD -Value 1 -Force | Out-Null
    
    # Disable New Windows Update UI and Enable Previous UI (requires ownership of the key)
    # New-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX" -Name IsConvergedUpdateStackEnabled -PropertyType DWORD -Value 0 -Force | Out-Null

    # Set explorer to open to "This PC"
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name LaunchTo -PropertyType DWORD -Value 1 -Force | Out-Null

    # Hide 'Search' bar (needs reboot or explorer.exe restart)
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name SearchboxTaskbarMode -PropertyType DWORD -Value 0 -Force | Out-Null
    
    # Disable UAC (requires reboot)
    New-ItemProperty -Path "HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system" -Name EnableLUA -PropertyType DWord -Value 0 -Force | Out-Null

    # Show file extensions
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -PropertyType DWORD -Value 0 -Force | Out-Null

    # Remove 'Customize this folder' from context menu
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name NoCustomizeThisFolder -Value 1 -PropertyType DWORD -Force | Out-Null

    # Remove 'Restore to previous versions' from context menu
    Remove-Item -Path "HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Force -Recurse | Out-Null

    # Remove 'Share with' from context menu
    Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -Force -Recurse | Out-Null
    reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Sharing" /f | Out-Null
    Remove-Item -Path "HKCR:\Directory\shellex\CopyHookHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Directory\shellex\PropertySheetHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\Drive\shellex\PropertySheetHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" -Force -Recurse | Out-Null
    Remove-Item -Path "HKCR:\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" -Force -Recurse | Out-Null
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name SharingWizardOn -PropertyType DWORD -Value 0 -Force | Out-Null

    # Remove Homegroup from left explorer pane
    # ~need to take ownership of the registry key and it's a PITA, so doing the easy thing instead by disabling the service
    # New-ItemProperty "HKCR:\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" -Name Attributes -PropertyType DWORD -Value 2962489612 -Force | Out-Null # hex: b094010c
    # New-ItemProperty "HKCR:\Wow6432Node\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" -Name Attributes -PropertyType DWORD -Value 2962489612 -Force | Out-Null # hex: b094010c

    # Remove 'Include in library' from context menu
    # Remove-Item "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Force -Recurse | Out-Null
    Remove-Item "HKLM:\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" -Force -Recurse | Out-Null

    # Remove 'Send to' from context menu
    Remove-Item -Path "HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" -Force -Recurse | Out-Null
    
    Write-Progress -Activity "Tweaking registry" -Status "Progress:" -PercentComplete 85

    # Fix DPI scaling blurry/fuzzy display at 125% (Might get reset by reboot/windows update)
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DpiScalingVer" -Value "0x00001018" -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Value "0x00000001" -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Value "0x00000078" -PropertyType DWORD -Force | Out-Null

    # Add a 'Take Owner' option in your right-click menu (Powershell has problems with '*', using reg.exe)
    reg add "HKEY_CLASSES_ROOT\*\shell\runas" /ve /t REG_SZ /d "Take Ownership" /f | Out-Null
    reg add "HKEY_CLASSES_ROOT\*\shell\runas" /v NoWorkingDirectory /t REG_SZ /d "" /f | Out-Null
    reg add "HKEY_CLASSES_ROOT\*\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \`"%1\`" && icacls \`"%1\`" /grant administrators:F" /f | Out-Null
    reg add "HKEY_CLASSES_ROOT\*\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \`"%1\`" && icacls \`"%1\`" /grant administrators:F" /f | Out-Null
   
    New-Item -Force -Path "HKCR:\Directory\shell\runas" | Out-Null
    New-Item -Force -Path "HKCR:\Directory\shell\runas\command" | Out-Null
    New-ItemProperty -Force -Path "HKCR:\Directory\shell\runas" -Name '(Default)' -Value "Take Ownership" | Out-Null
    New-ItemProperty -Force -Path "HKCR:\Directory\shell\runas" -Name NoWorkingDirectory -Value "" | Out-Null
    New-ItemProperty -Force -Path "HKCR:\Directory\shell\runas\command" -Name '(Default)' -Value "cmd.exe /c takeown /f `"%1`" /r /d y && icacls `"%1`" /grant administrators:F /t" | Out-Null
    New-ItemProperty -Force -Path "HKCR:\Directory\shell\runas\command" -Name IsolatedCommand -Value "cmd.exe /c takeown /f `"%1`" /r /d y && icacls `"%1`" /grant administrators:F /t" | Out-Null

    # Allows Powershell Invoke-WebRequest to be usable again, without generating a Security Dialog (for developers)
    New-ItemProperty -Force -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name 1A10 -Value 0 | Out-Null

    # Remove tablet lock screen (No need for in LTSB)
    # New-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name NoLockScreen -Value 1 -PropertyType DWORD -Force | Out-Null

    # Remove OneDrive completely
    $OneDrivex86 = "$env:SystemRoot\System32\OneDriveSetup.exe"
    $OneDrivex64 = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"

    Get-Process *OneDrive* | Stop-Process -Force | Out-Null
    Start-Sleep 3

    if (Test-Path $OneDrivex86)
    {
        & $OneDrivex86 "/uninstall" | Out-Null
    }

    if (Test-Path $OneDrivex64)
    {
        & $OneDrivex64 "/uninstall" | Out-Null
    }
    Start-Sleep 15 # Uninstallation needs time to let go off the files

    # Explorer.exe gets in our way by locking the files for some reason
    taskkill /F /IM explorer.exe | Out-Null
    if (Test-Path "$env:USERPROFILE\OneDrive") { rd "$env:USERPROFILE\OneDrive" -Recurse -Force | Out-Null }
    if (Test-Path "C:\OneDriveTemp") { rd "C:\OneDriveTemp" -Recurse -Force | Out-Null }
    if (Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive") { rd "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force | Out-Null }
    if (Test-Path "$env:PROGRAMDATA\Microsoft OneDrive") { rd "$env:PROGRAMDATA\Microsoft OneDrive" -Recurse -Force | Out-Null }
    Start-Process explorer.exe
    # Remove OneDrive from the Explorer Side Panel
    if (Test-Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}") { Remove-Item -Force -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse | Out-Null }
    if (Test-Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}") { Remove-Item -Force -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse | Out-Null }

    Write-Progress -Activity "Tweaking registry" -Status "Progress:" -PercentComplete 90
}
# Remove features
if ($features -eq $true)
{
    Write-Progress -Activity "Removing features" -Status "Progress:" -PercentComplete 90
    
    # XPS Viewer
    Dism /online /Disable-Feature /FeatureName:Xps-Foundation-Xps-Viewer /quiet /norestart
    # XPS Services
    Dism /online /Disable-Feature /FeatureName:Printing-XPSServices-Features /quiet /norestart
    # Internet Explorer
    Dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /quiet /norestart
    # Work Folders
    Dism /online /Disable-Feature /FeatureName:WorkFolders-Client /quiet /norestart

    Write-Progress -Activity "Removing features" -Status "Progress:" -PercentComplete 100
}
Write-Host "FINISHED." -ForegroundColor Green
Read-Host "Debloat complete. Please restart your system to make sure everything works properly."
