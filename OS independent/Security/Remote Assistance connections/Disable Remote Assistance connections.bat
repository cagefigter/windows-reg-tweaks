REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

netsh advfirewall firewall set rule group="Remote Assistance" new enable=no