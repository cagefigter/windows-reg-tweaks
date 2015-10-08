Start Administrator Command Prompt:

1. Terminate any process of OneDrive by running the following command: taskkill /f /im OneDrive.exe

2. Uninstall OneDrive app by running one of the following command:

In 32-bit Windows 10 (x86): %SystemRoot%\System32\OneDriveSetup.exe /uninstall

In 64-bit Windows 10 (x64): %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall


Now Cleaning and Removing OneDrive Remnants still in Administrator Command Prompt:

However, as OneDrive is a cloud storage service which is dealing with user data, there are remnants and leftovers from OneDrive app that are still available on the system as uninstallation does not remove user data, most prominently been the OneDrive folder. Run the commands below to clean up those remnants by deleting OneDrive related folders and their contents:

1. Type: rd "%UserProfile%\OneDrive" /Q /S

Now Reboot System an Start Administrator Command Prompt again and run those:

rd "%LocalAppData%\Microsoft\OneDrive" /Q /S
rd "%ProgramData%\Microsoft OneDrive" /Q /S
rd "C:\OneDriveTemp" /Q /S

Now Delete and Remove OneDrive in File Explorer Folder Tree Registry Key:

OneDrive has registry keys which add itself to the Navigation Pane of File Explorer in Windows 10. After uninstalling OneDrive, these registry keys are orphaned, and can be removed.

REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f