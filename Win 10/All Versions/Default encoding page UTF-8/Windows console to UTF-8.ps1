# This doesn't require editing the registry and, unlike editing a shortcut, will work if PowerShell is started in a specific folder using the Windows Explorer context menu.
# For PpowerShell
Set-ExecutionPolicy RemoteSigned
New-Item -Path $Profile -ItemType file -Force
notepad $Profile

# For console
New-Item -ErrorAction Ignore HKCU:\Console\%SystemRoot%_system32_cmd.exe
Set-ItemProperty HKCU:\Console\%SystemRoot%_system32_cmd.exe CodePage 65001