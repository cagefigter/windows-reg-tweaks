Windows Media Center version 6.3.9600.16384 (Windows 8.1)
for Windows 10 (10.10240.16384) and later, or Windows 8.1 with no Media Center
===============================================================================
Preparations:
- After you download the pack, make sure the .7z file is Unblocked
to do so, right click on file, check properties general - click Unblock button if present
- Extract the file to a directory with short spaceless path (example: C:\WMC) to avoid troubles
- Make sure there are no pending servicing updates operations
- If you previously used another/older pack, or your system is upgraded from Windows 7/8.1 with Media Center
you may run Uninstaller.cmd to remove the pack/leftovers properly, and reboot the system afterwards
===============================================================================
Installation:
1)
Run _TestRights.cmd script as administrator
if another command prompt window is opened, then close it and proceed to step 2)
if no cmd window opened, try again one or two more times
if still no cmd windows opened, then you need to reboot the system and test again.
2)
Run the outer Installer.cmd script as administrator to install the pack
===============================================================================
Note:
You may get some integrity errors which you can ignore (due the patched files, emulated dism package)
this includes:
sfc /SCANNOW
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /RestoreHealth