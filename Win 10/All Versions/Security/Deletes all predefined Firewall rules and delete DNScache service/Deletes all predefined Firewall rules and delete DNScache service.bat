@echo off
reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /F
pause
			
for %%X in (
"HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules"
"HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
"HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedInterfaces"
"HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices" ) do (
	reg delete %%X /F
	)
set X="HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices"
%~dp0\SetACL.exe -on %X% -ot reg -rec cont_obj -actn setowner -ownr "n:Everyone"
%~dp0\SetACL.exe -on %X% -ot reg -rec cont_obj -actn ace -ace "n:Everyone;p:full"
pause
			
for %%X in (
Defaults
Parameters ) do (
	for %%Y in (
	DomainProfile
	PublicProfile
	StandardProfile ) do (
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y" /V "DefaultInboundAction" /T REG_DWORD /D "1" /F
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y" /V "DefaultOutboundAction" /T REG_DWORD /D "1" /F
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y" /V "DisableNotifications" /T REG_DWORD /D "0" /F
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y" /V "DisableUnicastResponsesToMulticastBroadcast" /T REG_DWORD /D "1" /F
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y" /V "EnableFirewall" /T REG_DWORD /D "1" /F
		reg delete "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\%%X\FirewallPolicy\%%Y\Logging" /F
	)
)
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound
pause
			
Powershell New-NetFirewallRule -DisplayName "~System" -Name "System" -Direction Outbound -Program System -Action Allow
