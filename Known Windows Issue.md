The following _known issues_ are currently present in Windows 1809 (October Update). Before you submit any bug or feature request I expect that you read this document in order to get a short overview of what is broken and what can be manually fixed or needs an update (file changes). 

This overview is provides 'as it comes' and is not designed to explain every little 'fart', moreover it's designed to show quickly what are the 'urgent' things which are (as time of writing) considerably broken or needing a fix.


The list is checked against:
* Windows 10 
* Please don't ask for Home/Pro versions!




Problem | Description | Workaround | Fix | Additional Information 
--- | --- | --- | --- | --- |
I'm getting Intel Audio Controller version 9.21.0.3755 Update | You get the Intel Audio Driver without any need via WUS | Uninstall it manually, see [here](https://blogs.msdn.microsoft.com/matthew_van_eerde/2018/10/12/if-windows-update-sent-you-intel-audio-controller-version-9-21-0-3755-by-mistake-uninstall-it/) or exclude the drivers/updates via [WuMgr](https://github.com/DavidXanatos/wumgr) | // | //
HpqKbFiltr.sys BSOD after KB4464330 + KB4462919 | After using the updates while using HP printers/drivers you might receive a Bluescreen | ren C:\Windows\System32\drivers\HpqKbFiltr.sys HpqKbFiltr.sys_old | [x64](http://download.windowsupdate.com/c/msdownload/update/software/crup/2018/10/hpqkbfiltrremove_160aa8311398d21242ef673ff567b30da5a1a315.exe) + [x86](http://download.windowsupdate.com/c/msdownload/update/software/crup/2018/10/hpqkbfiltrremove_160aa8311398d21242ef673ff567b30da5a1a315.exe) | [Reddit](https://www.reddit.com/r/Windows10/comments/9n0bkw/one_of_these_quality_updates_can_cause_an/)
Windows 10 Build 1809 deleted all my libary files | Files located under e.g. /Documents/ getting deleted during a feature upgrade | Make sure [KB4464330](https://support.microsoft.com/en-us/help/4464330/windows-10-update-kb4464330) is installed/integrated (make sure you search for updates during the upgrade). | Not fixable, but you can try to recover your files via e.g. [Recuva](https://www.ccleaner.com/recuva) | Reported over [MS forums](https://answers.microsoft.com/en-us/windows/forum/windows_10-files/windows-10-october-2018-update-version-1809/1a924008-ddba-48db-a96f-7b4bfef9039a) and MS pulled the build in the meantime.
LIPs (Language Interface Packs) aren't avbl. anymore | Microsoft removed the LIP's function in order to install additional lp's | // | // | LXP (Local Experience Packs) replacing the LIPs 
Handwriting gets stored in a seperate file | Every touch/handwriting input is stored in a index file called '[WaitList.dat](https://b2dfir.blogspot.com/2016/10/touch-screen-lexicon-forensics.html)' which can be recovered (including passwords etc) | Delete `C:\Users\%User%\AppData\Local\Microsoft\InputPersonalization\TextHarvester\WaitList.dat` manually or use [wlrip.exe](https://github.com/B2dfir/wlrip) ([wlrip](https://github.com/B2dfir/wlrip)) | // | MS needs to fix it  
Game stuttering | Game is starting to stutter if your OS is low on memory and doesn't free it's resources | [Script](https://www.reddit.com/r/Windows10/comments/9e1yy4/when_will_the_free_memory_bug_bug_be_fixed/) | Needs confirmation by MS | It's unclear if it's really a 'bug' 
Edge, Apps and Store getting no updates or can't connect | Whenever Ipv6 is disabled the apps might not getting any connection | [Enable IPv6 in your network adapter](https://i.imgur.com/iTiBhqh.png) | // | MS needs to verify and fix it 
My provider doesn't offer Printer Drivers | Since 1809 each print driver comes over WSUS, the print driver standards are now [Mopria](https://mopria.org/de/what-is-mopria) | You can only download the driver online or via Mopria (this is often offered by the manufracturer) as "normal" driver update | // | [This is by design](https://techcommunity.microsoft.com/t5/Windows-IT-Pro-Blog/What-s-new-in-printing-in-Windows-10-version-1809/ba-p/267182) 


## Install Language Packs (1809+)

Language packs will still be avbl. via [seperated .iso files](https://www.microsoft.com/de-de/store/collections/localexperiencepacks?rtc=1).

1.) Mount the install.wim via:
`dism.exe /mount-wim /wimfile:C:\install.wim /index:1 /mountdir:C:\Mount`

2.) Mount the registry otherwise you're not able to integrate the new language via 
`Reg Load HKLM\TempImg C:\Mount\Windows\system32\config\SOFTWARE`

3.) Insert the following registry key:
`Reg Add HKLM\TempImg\Policies\Microsoft\Windows\Appx /t REG_DWORD /f /v "AllowAllTrustedApps" /d "1"`

4.) Unmount the registry:
`Reg unload HKLM\TempImg`

5.) Integrated the [LXP.Appx](https://docs.microsoft.com/en-us/powershell/module/dism/add-appxprovisionedpackage?view=win10-ps) for example: 
`Dism.exe /image:C:\Mount /add-provisionedappxpackage /packagepath:C:\LXP_APPX\Microsoft.LanguageExperiencePackde-DE_17761.1.1.0_neutral__8wekyb3d8bbwe.Appx /SkipLicense`

6.) Unmount the image
`Dism.exe /unmount-wim /mountdir:C:\Mount /commit`


## Spectre & Meltdown 

![Spectre and Meltdown on Intel Hardware](https://i.imgur.com/WPiOGpZ.png)

**Overview**:
* [V3a](https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/download-the-whitepaper) (new "Meltdown" variant)
* [V4](https://software.intel.com/side-channel-security-support) ([CVE 2017-5715](https://www.neowin.net/news/spectre-variant-4-disclosed-mitigations-to-result-in-another-performance-hit))
* [L1TF](https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00161.html)

[Supported CPU's](https://support.microsoft.com/en-us/help/4100347/intel-microcode-updates-for-windows-10-version-1803-and-windows-server):

* Broadwell Server E, EP, EP4S
* Broadwell Server EX
* Skylake Server SP (H0, M0, U0)
* Skylake D (Bakerville)
* Skylake X (Basin Falls)

Patched .dll's:

* mcupdate_GenuineIntel.dll
* mcupdate_AuthenticAMD.dll

Windows has the ability to warm patch microcode on boot using the mcupdate_GenuineIntel.dll and mcupdate_AuthenticAMD.dll drivers (located at C:\Windows\System32) on boot, for Intel and AMD cpu's respectively.

Notice:

On AMD systems you _can block the update_ via [wushowhide.diagcab](https://support.microsoft.com/de-de/help/3073930/how-to-temporarily-prevent-a-driver-update-from-reinstalling-in-window), since the update will effect your performance. 

OS Version | KB | Patch | Updated
--- | --- | --- | --- 
Windows 10 1507 | [KB4091666](https://support.microsoft.com/en-us/help/4091666/kb4091666-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091666) | 10. Oct. 2018 |
Windows 10 1511 | // | // | // |
Windows 10 1607 | [KB4091664](https://support.microsoft.com/en-us/help/4091664/kb4091664-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091664) | 10. Oct. 2018 |
Windows 10 1703 | [KB4091663](https://support.microsoft.com/en-us/help/4091663/kb4091663-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091663) | 10. Oct. 2018 |
Windows 10 1709 | [KB4090007](https://support.microsoft.com/en-us/help/4090007/intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4090007) | 10. Oct. 2018 |
Windows 10 1803 | [KB4100347](https://support.microsoft.com/en-us/help/4100347/intel-microcode-updates-for-windows-10-version-1803-and-windows-server) | [Download](https://www.catalog.update.microsoft.com/search.aspx?q=4100347) | 10. Oct. 2018 |
Windows 10 1809 | [KB4465065](https://support.microsoft.com/en-us/help/4465065/kb4465065-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=kb4465065) | 27. Nov 2018 |


## Acknowledgments and References

* [Windows 10 release information](https://www.microsoft.com/en-us/itpro/windows-10/release-information)
* [How to temporarily prevent a driver update from reinstalling in Windows 10](https://support.microsoft.com/en-us/help/3073930/how-to-temporarily-prevent-a-driver-update-from-reinstalling-in-window)
* [How to keep apps removed from Windows 10 from returning during an update](https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update#registry-keys-for-provisioned-apps)
* [When Microsoft patches security vulnerabilities and when not](https://www.microsoft.com/en-us/msrc/windows-security-servicing-criteria?rtc=2) - see also [MSRC (.pdf)](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2A3xt)
* [Intel Microcode Update Guidance (.pdf)](https://newsroom.intel.com/wp-content/uploads/sites/11/2018/04/microcode-update-guidance.pdf)
