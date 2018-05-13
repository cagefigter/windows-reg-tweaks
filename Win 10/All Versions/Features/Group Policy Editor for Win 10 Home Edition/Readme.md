Windows (no matter which versions) comes with Group Policy Editor packages, but on the Home Edition it's disabled by default. You can install it just like any other optional feature via dism.

The Group Policy package files can be found under: `%SystemRoot%\servicing\Packages`


With filenames matching:

```
Microsoft-Windows-GroupPolicy-ClientExtensions-Package*.mum
Microsoft-Windows-GroupPolicy-ClientTools-Package*.mum
```


And command for installing would follow the following format:

```
dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\{{PackageFileName}}"

```

`/online` used to tell it to apply to the running OS and `/norestart` tells the OS not to auto reboot.

After installing the gpedit.msc command can be used. You don't need to download an external executable that you have to trust or find out if it is safe or not.