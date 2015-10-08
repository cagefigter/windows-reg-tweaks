reg add "HKCR\Directory\shell\cmdhere" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f
reg add "HKCR\Directory\shell\cmdhere" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-37415" /f
reg add "HKCR\Directory\shell\cmdhere" /v "Position" /t REG_SZ /d "Bottom" /f
reg add "HKCR\Directory\shell\cmdhere" /v "SubCommands" /t REG_SZ /d "Windows.MultiVerb.cmd;Windows.MultiVerb.cmdPromptAsAdministrator;|;Windows.MultiVerb.Powershell;Windows.MultiVerb.PowershellAsAdmin" /f
reg add "HKCR\Directory\Background\shell\cmdhere" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f
reg add "HKCR\Directory\Background\shell\cmdhere" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-37415" /f
reg add "HKCR\Directory\Background\shell\cmdhere" /v "Position" /t REG_SZ /d "Bottom" /f
reg add "HKCR\Directory\Background\shell\cmdhere" /v "SubCommands" /t REG_SZ /d "Windows.MultiVerb.cmd;Windows.MultiVerb.cmdPromptAsAdministrator;|;Windows.MultiVerb.Powershell;Windows.MultiVerb.PowershellAsAdmin" /f
reg add "HKCR\Drive\shell\cmdhere" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f
reg add "HKCR\Drive\shell\cmdhere" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-37415" /f
reg add "HKCR\Drive\shell\cmdhere" /v "Position" /t REG_SZ /d "Bottom" /f
reg add "HKCR\Drive\shell\cmdhere" /v "SubCommands" /t REG_SZ /d "Windows.MultiVerb.cmd;Windows.MultiVerb.cmdPromptAsAdministrator;|;Windows.MultiVerb.Powershell;Windows.MultiVerb.PowershellAsAdmin" /f

reg delete "HKEY_CLASSES_ROOT\Directory\shell\cmdhere" /f
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\cmdhere" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shell\cmdhere" /f