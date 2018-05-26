The following known issue are currently present in Windows 1803 (Spring Creators Update aka April Update). Before you submit any bug or feature request I expect that you read this document in order to get a short overview what is broken and what can be manually fixed or needs an update (file changes). 

The document is provides 'as it' and is not designed to explain every little 'fart', moreover it's designed to show quickly what are the 'urgent' things which are (as time of writing) considerable broken or needs a fix.


The list is checked against:
* Windows 10 1803 Ent. VL OEM (en_windows_10_business_editions_version_1803_updated_march_2018_x64_dvd_12063333). 
* Please don't ask for Home/Pro versions! I give a rats-ass about those versions but feel free to submit something if you like.




Problem | Description | Workaround | Fix | Additional Information 
--- | --- | --- | --- | --- |
Unnecessarily writing on SSD will shorten the lifetime | [fsutil behavior set disablelastaccess](https://translate.google.com/translate?hl=en&sl=ja&u=http://blog.livedoor.jp/nichepcgamer/archives/1071061265.html&prev=search) | fsutil behavior set disablelastaccess 1 | [Here](https://github.com/CHEF-KOCH/regtweaks/blob/master/Win%2010/RS%204%20(1803)/SSD/NtfsDisableLastAccessUpdate.reg) | //
Windows Cortana WebSearch can't be globally turned off | Disabling WebSearch via GPO or registry globally (HKEY_LOCAL_MACHINE) doesn't work | You only can set it [per user basis](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Features/Cortana%20WebSearch) (HKEY_CURRENT_USER) | // | Needs fixed by MS
Chrome, Edge freezes due [broken hardware decoder | The original issue ticket can be found [here](https://bugs.chromium.org/p/chromium/issues/detail?id=838809), [some Reddit user reporting not only Chrome is affected](https://www.reddit.com/r/Windows10/comments/8gf68w/chrome_freezes_windows_after_april_update/), see also [here](https://www.reddit.com/r/Windows10/comments/8guv3d/edge_high_cpu_usage_with_youtube/) | //  | Fixed with 17134.5+ | [Neowin](https://www.neowin.net/news/google-chrome-is-freezing-intermittently-with-the-windows-10-april-2018-update)
Homegroup glitches | Homegroup was removed, there still GUI toggles (not working), this needs to be fixed with an GUI update. | Ignore it | Remove some leftovers manually | //
Duplicate `Settings` | Settings panel is still available as Win32 and UWP app | // | // | Possible never gets fixed cause [MS is too incompetent to make a UWP switch](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/All%20Versions/Discussion%20-%20Microsoft%20and%20Quality) cause it would break half of the current code. 
GUI glitches in Windows Defender | By design there some shadow/animation glitches also called 'glaring bug'. | // | // | Needs to be fixed by MS 
Strange Unicode symbols in Registry | See [here](https://imgur.com/a/nTIc8j0). | // | // | //
Background apps restart automatically after a restart | Even after using Registry or [GPO settings on Home Edition](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/All%20Versions/Features/Group%20Policy%20Editor%20for%20Win%2010%20Home%20Edition) | [Workaround for Pro/Ent. users](https://old.reddit.com/r/Windows10/comments/8i6wkj/whenever_i_turn_my_pc_on_background_apps_turns/). | See [here](https://blogs.technet.microsoft.com/mniehaus/2015/11/23/seeing-extra-apps-turn-them-off/]) & [here](https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update). | GPO needs fixed by MS
Sound crackling | Crackling during Music/Video playback | [Needs confirmation](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Audio%20crackling%20fix%20%5BTEST!%5D) | Fixed with 8451 | //
Spotlight doesn't work | // | A Workaround is [here](https://www.reddit.com/r/Windows10/comments/8gxxs2/aio_fix_windows_10_any_version_spotlight_not/). | // | Needs to be fixed by MS
Color Theme can't be set to 'simple black' | No black accent color choosable | A regfix is [here](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Theme/Black%20accent%20color)  | // | Needs to be changed by MS
Delayed mouse reactions | VSync seems to be broken (for some people ?) Needs confirmation | Change the driver? | // | //
Unusable microphone | Microsoft added new permission blacklists in order to block illegal access to webcam/mic | // | Settings > Privacy. See if microphone access is allowed for apps. | //
Context menu doesn’t appear | Some users don't see the context menu | // | Install a new graphic cards driver | //
Fixes for Spectre NG (Variant 4) | // | // | unpatched | //
Diagnostic data can't be changed | [Some users see “Windows Insider Program manages this option”](https://imgur.com/a/mpMw8Co) when they try to change the diagnostic data upload options in Settings > Privacy > Diagnostics & Feedback. | // | // | Needs to be fixed by MS
Icon and GUI glitches | See [here](https://medium.com/@itsmichaelwest/things-wrong-with-the-ui-ux-in-the-windows-10-april-2018-update-ce9c5aebbd32). | // | // | Needs to be fixed by MS
Frame drops in D3D9 games | Some games dropping frames mostly DirectX9 based ones | Enable "Disable fullscreen optimizations" and "Override DPI Scaling" & Turn off/on Windows 10 game boost, and the boost setting you turn on/off on the overlay | // | Needs to be changed by Game Developers to adopt MS 'game optimization feature' 
IPv6 DNS RA and other flags are none functional | Stateless-DHCP, Router Advertisements flags are been ignored | Downgrade to Build 1703 | // | [Needs to be fixed by MS](https://social.technet.microsoft.com/Forums/windows/en-US/b16e7d78-e390-4ada-a24b-3ccba60fa571/no-ipv6-dns-statelessdhcp-since-windows-10-anniversary-update?forum=win10itpronetworking).
MAC address randomization is gone | On Home and Pro (?) versions the option is not available anymore | Install another driver | // | MS has changed this behavior, however this [feature is not as affective as you might think](https://searchsecurity.techtarget.com/tip/MAC-address-randomization-schemes-Examining-the-pros-and-cons). 
nVidia games changing the color profiles | Washed out colors with nVidia drivers | See [here](https://forums.geforce.com/default/topic/966561/finally-a-fix-for-the-games-changing-the-color-profiles-/). | New drivers ? | // 
CDPUserSvc is using CPU constantly | Freezes + Crashes and lags can appear | // | // | Needs to be fixed by [MS](https://aka.ms/AA17j2v).
Slow Alt+Tab | Alt+Tab while Gaming is slow/slower | Windows key--->Configuration(the gear)--->System--->Focus Assist--->DISABLE everything! | // | // 
Speakers Enhancements are automatically reset | Realtek, Creative etc enhancements are automatically reset after restart | // | // | Needs to be fixed by [MS](https://aka.ms/AA17iws).
You can't remove redundant keyboard language packs | [English (US) Language Pack is not removable](https://i.redditmedia.com/B_UPLuUc9SwhuCCX1r7Ch8ahjZnpyckjXm3-fohwgGw.png?w=1024&s=428c3794801af5fbcacd70e20369faff) | [Workaround](https://www.reddit.com/r/windows/comments/8hi21r/fix_1803_cannot_remove_english_us_language_pack/) | // | Needs to be fixed by [MS](https://aka.ms/AA1615h).
Windows uses GiB instead of GB | SI is wrong | // | // | Needs to be fixed by MS 
When switching the refresh rate from 59 Hz to 60Hz the refresh rate remains at 59 Hz | [Screen refresh rate in Windows does not apply the user selected settings on monitors & TVs (that report specific TV compatible timings)](https://support.microsoft.com/en-us/help/2006076/screen-refresh-rate-in-windows-does-not-apply-the-user-selected-settin) | // | There will never be a fix cause it's not nVidia/AMD or Windows related issue. | You can 'fix' this via [CRU](https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU)
12 bpc is automatically applied even on HDTVs that support only 8 bpc, resulting in a scrambled display | Windows 10 Fall Creators Update Bug 2007663 | Open the NVIDIA Control Panel -> Change Resolution page, select Use NVIDIA color settings, then set the Output color depth to 8 bpc. | Maybe with other drivers? (unconfirmed) | //
RDP App might not work | More details [here](https://support.microsoft.com/en-us/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018) | Use third-party RDP app | Wait till CredSSP protocol got an update, you need to update your server. This is not a bug at all, it's due security reasons! | [CVE-2018-0886](https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/CVE-2018-0886) 
Reliability issues have been observed during the creation of shielded VMs and the required artifacts for their deployment. There are also reliability issues for the Shielding File Wizard with or without the SCVMM interface. | Existing shielded VMs and HGSs are not affected. | // | MS needs to fix it | //
Ghost partition appears | New partitions may appear in File Explorer after installing the Windows 10 April 2018 Update (version 1803) | See [here](https://answers.microsoft.com/en-us/windows/forum/windows_10-files/new-partitions-may-appear-in-file-explorer-after/115d2860-542e-410f-983c-2aeb8bbd7d13) | // | Fixed with Build 17134.48
Event-ID 502 `„Failed to apply policy and redirect folder „RoamingAppData“ to „„.` | Redirection options=0x1211. The following error occurred: „The folder is not redirectable.“. | // | // | Fixed with next Insider build 



## Spectre 


Spectre NG ([Variant 4](https://www.neowin.net/news/spectre-variant-4-disclosed-mitigations-to-result-in-another-performance-hit)) isn't patched (yet).

OS Version | KB | Patch | Microcode for CPU
--- | --- | --- | --- 
Windows 10 1507 | [KB4091666](https://support.microsoft.com/en-us/help/4091666/kb4091666-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091666) | Sandy Bridge, Ivy Bridge, Haswell, Broadwell,
Skylake |
Windows 10 1511 | // | // | // |
Windows 10 1607 | [KB4091664](https://support.microsoft.com/en-us/help/4091664/kb4091664-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091664) | Sandy Bridge, Ivy Bridge, Haswell, Broadwell,
Skylake, Kaby Lake, Coffee Lake |
Windows 10 1703 | [KB4091663](https://support.microsoft.com/en-us/help/4091663/kb4091663-intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4091663) | Sandy Bridge, Ivy Bridge, Haswell, Broadwell,
Skylake, Kaby Lake, Coffee Lake |
Windows 10 1709 | [KB4090007](https://support.microsoft.com/en-us/help/4090007/intel-microcode-updates) | [Download](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4090007) | Sandy Bridge, Ivy Bridge, Haswell, Broadwell,
Skylake, Kaby Lake, Coffee Lake |
Windows 10 1803 | [KB4100347](https://support.microsoft.com/en-us/help/4100347/intel-microcode-updates-for-windows-10-version-1803-and-windows-server) | [Download](https://www.catalog.update.microsoft.com/search.aspx?q=4100347) | Sandy Bridge, Ivy Bridge, Haswell, Broadwell,
Skylake, Kaby Lake, Coffee Lake |





* [How to temporarily prevent a driver update from reinstalling in Windows 10](https://support.microsoft.com/en-us/help/3073930/how-to-temporarily-prevent-a-driver-update-from-reinstalling-in-window)
* [How to keep apps removed from Windows 10 from returning during an update](https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update#registry-keys-for-provisioned-apps)
