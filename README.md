Regtweaks (Win 7 - Win 10) Collection files original created under the GPL 2.0 license 2015 - 2018 by [CHEF-KOCH](https://github.com/CHEF-KOCH). Some tweaks are taken from the Internet but most tweaks are found by myself.


## Microsoft pulls Windows 10 October Update (version 1809)


Microsoft cites problems with the latest update package deleting user files. [Microsoft has paused the rollout of Windows 10 October 2018 Update (version 1809)](https://www.engadget.com/2018/10/06/windows-10-october-update-delete-pulled/), the latest version of the Windows 10 operating system, which Microsoft released this week, on Tuesday, October 2. In a [support document updated today](https://support.microsoft.com/en-us/help/4464619/windows-10-update-history), October 6, the Redmond-based OS maker said it took this decision after users complained that v1809 had deleted files after the update. The cause seems that the [Download folder was silently by default added to the Disk Cleanup tool list](https://www.windowslatest.com/2018/10/08/disk-cleanup-can-now-wipe-your-downloads-folder-in-windows-10-version-1809/) which gets executed based on what is set to the task schedule. 


* - [KB4464330](https://support.microsoft.com/en-us/help/4464330/windows-10-update-kb4464330) fixes the issue. [A RTM refresh build is pushed to Insiders](https://blogs.windows.com/windowsexperience/2018/10/09/updated-version-of-windows-10-october-2018-update-released-to-windows-insiders/). 
* - [Intel Driver Issues Force Another Windows 10 October 2018 Update Delay](https://www.google.co.in/amp/s/amp.tomshardware.com/news/microsoft-delays-windows-10-october-2018-update-intel-drivers,38126.html)


<p align="center">
  <img width="500" height="320" src="https://raw.githubusercontent.com/CHEF-KOCH/regtweaks/master/Current%20Windows.jpg")">
</p>

**Current Status: Over 600+ tweaks**


[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40CHEF-KOCH)](https://twitter.com/CKsTechNews)
[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/CHEF-KOCH)
[![Discord](https://discordapp.com/api/guilds/418256415874875402/widget.png)](https://discord.me/CHEF-KOCH)


Before! you use any tweak(s) ensure you read the comment(s) inside the .reg (labeled with **;**) to see what it really changes. Of course a backup/snapshot could also help in case something goes wrong. Remember: Shit happens!



Project Goal(s)
------------

1. All of the tweaks could be integrated into image creations tools (vLite, WinToolKit,..) to simplify things, especially if you like to re-install Windows from the ground without need to apply each tweak one by one.
2. Show hidden things that aren't visible via GUI under Windows. Sometimes it's easier/faster to do this via .reg instead of search for the toggles.
3. Another goal is that the user doesn't need additional tools like O&O ShutUp, because some of such 'privacy' tools are bundled with bloatware and are not necessary, because all can already be done with scripts and .reg tweak - So overall an Index/Backup script to read the current state is more transparent (see 1/2).
4. [Provide a short overview of current Windows issue](https://github.com/CHEF-KOCH/regtweaks/blob/master/Known%20Windows%20Issue.md) and how to quickly solve them.
5. Fix everything listed under ToDo.




RegTweaks is free, but powered by your support
------------

There are many reoccurring costs involved with maintaining free, open source and privacy respecting programs. As you probably know, developing quality applications takes much time and resources. Your donation will make it possible to keep my the current development standard.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://github.com/CHEF-KOCH/Donations)


Any problems, questions or something wrong?
------------

* Feel free to open an [issue ticket](https://github.com/CHEF-KOCH/regtweaks/issues) and I will look at it asap. - Pull requests or ideas are always welcome!
* Please do not use the issue tracker to ask for xyz tweaks, I not waste my time with that until there is a very good reasons to do so. If you found something that wasn't added here contact me and I will add it.
* Windows 7 - 8 support is limited, I simply don't have time to check every OS and I personally won't support it anymore because my philosophy is to use the latest OS due security reasons.



Find registry settings yourself
------------

To answer the question how do I find all these registry tweaks, it's very easy and explained with pictures and an example video which you can find over [here](https://chefkochblog.wordpress.com/2018/02/28/how-i-find-every-registry-tweak/).



Find hidden Windows features yourself
------------

[Mach2](https://github.com/riverar/mach2) is not an official Microsoft program. Nevertheless, you can still [download it from it's Github page](https://github.com/riverar/mach2/releases). It's recommended you run the tool with `--help` for details on how to use the tool. In order to find hidden features, Mach2 needs to scan PDB files, otherwise known as Program Database files, which contain debug symbols for the Windows executables. The problem, though, is that these symbol files are not installed with Windows and you need to download them from Microsoft's Symbol Server.

A complete guide is [available here](https://www.bleepingcomputer.com/news/microsoft/finding-and-enabling-hidden-features-in-windows-10-using-mach2/).

Keep in mind that not all feature IDs can be found within Windows debugging symbols. [Capstone](https://github.com/aquynh/capstone) is still needed in order to disassemble all hidden details.


Win 7 - 10 "Home" Edition Users Notice
------------

The Home Editions doesn't official supporting the GPEDIT.MSC stuff, so here is how to add them back [here's the link how](http://drudger.deviantart.com/art/Add-GPEDIT-msc-215792914) or [this](http://www.askvg.com/how-to-enable-group-policy-editor-gpedit-msc-in-windows-7-home-premium-home-basic-and-starter-editions/).

In order to get RDP (Remote Desktop Protocol) in Home Editions simply use [rdpwrap](https://github.com/stascorp/rdpwrap/). 



Project History
------------

- [x] 15.09.2018  Placeholder Logo added
- [x] 04.05.2018	Mach2 will be integrated into the GUI, until then I provide links to the project and an external guide how to find hidden Windows features in Insider Builds
- [x] 18.07.2017    GUI is done, some internal fixes before rolling out at the end of this year, some cleanups are necessary
- [x] 13.04.2017    Second and last GUI beta test
- [x] 26.01.2017    First beta GUI tests
- [x] 31.05.2016    First internal GUI tests 
- [x] 01.09.2015	All tweaks are now in English.
- [x] 25.08.2015	Added some image creation tools which are able handle the registry tweaks.
- [x] 18.08.2015	Initial upload and first release.



ToDo
------------

- [ ] Add Windows 'urgent' Bug List (requested) (mid-prio)
- [ ] Add new tweaks (all time high-prio)
- [ ] Adapt or integrate Mach2 within the GUI (Work-in-Process WiP)
- [x] Sort all tweaks maybe via .html or .js parser to easier access them with e.g. a search function (like RSW?) (main-prio) in other words: GUI Client
- [x] Delete duplicates (high-prio)
- [x] Remove not working ones of course this needs some testers (high-prio)
- [x] Rename tweaks to english (some are in ger./ru.) (high-prio)
- [ ] Fix [reported problems](https://github.com/CHEF-KOCH/regtweaks/issues) (high-prio)
- [x] Add on/off toggles (registry/batch files) to revert all changes in case something goes wrong


Research
------------

* [Crash Course in Upgrading to Windows 10](https://resources.office.com/ww-landing-M365PD-EOL-crash-course-in-upgrading-to-windows-10-ebook.html?LCID=en)
* [Vista Registry Editor - Examples of .Reg Files](http://www.computerperformance.co.uk/vista/vista_registry_tweaks.htm)
* [Sevenforums Tutorial Index](http://www.sevenforums.com/tutorials/257-windows-7-tutorial-index.html)
* [Microsoft Is Downloading 6GB of Windows 10 Updates Without User’s Consent (nextbigwhat.com)](http://www.nextbigwhat.com/microsoft-is-downloading-6gb-of-windows-10-updates-without-users-consent-297/)
* [O&O ShutUp10](http://www.oo-software.com/en/shutup10)
* [RSAT for Windows 10](https://www.microsoft.com/en-us/download/details.aspx?id=45520)
* [NTLite](https://www.ntlite.com)
* [WinToolkit](https://www.Wincert.net)
