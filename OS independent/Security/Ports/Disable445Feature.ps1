Function Disable445Feature
{
    $netBTParametersPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
    IF(Test-Path -Path $netBTParametersPath) {
        Set-ItemProperty -Path $netBTParametersPath -Name "SMBDeviceEnabled" -Value 0
    }
    Set-Service lanmanserver -StartupType Disabled
    Stop-Service lanmanserver -Force
}

Disable445Feature

