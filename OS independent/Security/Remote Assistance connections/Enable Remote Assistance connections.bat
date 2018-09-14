REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

netsh advfirewall firewall set rule group="Remote Assistance" new enable=yes
