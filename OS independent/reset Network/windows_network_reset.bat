rem USE AT OWN RISK AS IS WITHOUT WARRANTY OF ANY KIND !!!!!

sc config BFE start= auto
sc config Dhcp start= auto
sc config Dnscache start= auto
sc config DPS start= auto
sc config lmhosts start= auto
sc config MpsSvc start= auto
sc config NlaSvc start= auto
sc config nsi start= auto
sc config Wcmsvc start= auto
sc config Winmgmt start= auto

sc config NcbService start= demand
sc config Netman start= demand
sc config netprofm start= demand
sc config WinHttpAutoProxySvc start= demand
sc config WlanSvc start= demand
sc config WwanSvc start= demand

net start DPS
net start BFE
net start nsi
net start NlaSvc
net start Dnscache
net start Dhcp
net start Wcmsvc
net start MpsSvc

rem Disable adapter with index number 0-5 (most likely all), equals to ipconfig /release
wmic path win32_networkadapter where index=0 call disable
wmic path win32_networkadapter where index=1 call disable
wmic path win32_networkadapter where index=2 call disable
wmic path win32_networkadapter where index=3 call disable
wmic path win32_networkadapter where index=4 call disable
wmic path win32_networkadapter where index=5 call disable

rem Timeout to let the network adapter recover
timeout 5

rem Enable adapter with index number 0-5 (most likely all), equals to ipconfig /renew
wmic path win32_networkadapter where index=0 call enable
wmic path win32_networkadapter where index=1 call enable
wmic path win32_networkadapter where index=2 call enable
wmic path win32_networkadapter where index=3 call enable
wmic path win32_networkadapter where index=4 call enable
wmic path win32_networkadapter where index=5 call enable

rem advfirewall  - technet.microsoft.com/en-us/library/cc771046(v=ws.10).aspx
rem arp - technet.microsoft.com/en-us/library/cc940107.aspx
rem ipconfig - technet.microsoft.com/en-us/library/bb490921.aspx
rem nbtstat - technet.microsoft.com/en-us/library/bb490938.aspx
rem netsh - technet.microsoft.com/en-us/library/cc770948(v=ws.10).aspx
rem route - technet.microsoft.com/en-us/library/bb490991.aspx
rem support.microsoft.com/en-us/help/10741/windows-10-fix-network-connection-issues

arp -d *
route -f
nbtstat -R
nbtstat -RR
netsh advfirewall reset

netcfg -d
netsh winsock reset
netsh int 6to4 reset all
netsh int httpstunnel reset all
netsh int ip reset
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
ipconfig /release
ipconfig /renew
ipconfig /flushdns

rem Force restart in 1 minute
shutdown /r /t 60

rem If you get "Access denied" message, take ownership of the following key in registry, then set Permissions for the current user to Allow Full Control or try to run BAT in the safe mode
rem HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nsi\{eb004a00-9b1a-11d4-9123-0050047759bc}\26

notepad c:\windows\system32\drivers\etc\hosts

rem Make sure, that no IPs are blocked in HOSTS, only those 2 entries should be there:
rem #	127.0.0.1       localhost
rem #	::1             localhost

rem To disable restart, type - shutdown /a

pause
