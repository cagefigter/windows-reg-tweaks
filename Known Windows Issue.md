The following known issue are currently present in Windows 1803. Before you submit any bug or feature request I expect that you read this document in order to get a short overview what is broken and what can be manually fixed or needs an update (file changes). 

The document is provides 'as it' and is not designed to explain every little 'fart' or possible issue, moreover it's to show quickly what are the 'urgent' things which are (as time of writing) considerable broken.


The list is checked against:
* Windows 10 1803 Ent. VL OEM. 
* Please don't ask for Home/Pro! I give a rats-ass about those versions but feel free to submit something if you like to.


Problem | Description | Workaround | Fix | Additional Information 
--- | --- | --- | --- | --- |
Unnecessarily writing on SSD will shorten the lifetime | [fsutil behavior set disablelastaccess](https://translate.google.com/translate?hl=en&sl=ja&u=http://blog.livedoor.jp/nichepcgamer/archives/1071061265.html&prev=search) | fsutil behavior set disablelastaccess 1 | [Here](https://github.com/CHEF-KOCH/regtweaks/blob/master/Win%2010/RS%204%20(1803)/SSD/NtfsDisableLastAccessUpdate.reg) | //
Windows Cortana WebSearch can't be globally turned off | Disabling WebSearch via GPO or registry globally (HKEY_LOCAL_MACHINE) doesn't work | You only can set it [per user basis](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Features/Cortana%20WebSearch) (HKEY_CURRENT_USER) | // | Needs fixed by MS
Chrome, Edge freezes due [broken hardware decoder | The original issue ticket can be found [here](https://bugs.chromium.org/p/chromium/issues/detail?id=838809), [some Reddit user reporting not only Chrome is affected](https://www.reddit.com/r/Windows10/comments/8gf68w/chrome_freezes_windows_after_april_update/), see also [here](https://www.reddit.com/r/Windows10/comments/8guv3d/edge_high_cpu_usage_with_youtube/) | //  | Fixed with 17134.5+ | [Neowin](https://www.neowin.net/news/google-chrome-is-freezing-intermittently-with-the-windows-10-april-2018-update)
Homegroup glitches | Homegroup was removed, there still GUI toggles (not working), this needs to be fixed with an GUI update. | Ignore it | Remove some leftovers manually | //
Duplicate `Settings` | Settings panel is still available as Win32 and UWP app | // | // | Possible never gets fixed cause [MS is too incompetent to make a UWP switch](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/All%20Versions/Discussion%20-%20Microsoft%20and%20Quality) cause it would break half of the current code. 
GUI glitches in Windows Defender | By design there some shadow/animation glitches also called 'glaring bug'. | // | // | Needs to be fixed by MS 
Strange Unicode symbols in Registry | See [here](https://imgur.com/a/nTIc8j0). | // | // | //
Background apps re-start automatically after a restart | Even after using Registry/GPO settings | // | // | GPO needs fixed by MS
Sound crackling | Crackling during Music/Video playback | [Needs confirmation](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Audio%20crackling%20fix%20%5BTEST!%5D) | by Realtek, Asus, Creative Driver or MS update? | //
Spotlight doesn't work | // | A Workaround is [here](https://www.reddit.com/r/Windows10/comments/8gxxs2/aio_fix_windows_10_any_version_spotlight_not/). | // | Needs to be fixed by MS
Color Theme can't be set to 'simple black' | No black accent color choosable | A regfix is [here](https://github.com/CHEF-KOCH/regtweaks/tree/master/Win%2010/RS%204%20(1803)/Theme/Black%20accent%20color)  | // | Needs to be changed by MS
Delayed mouse reactions | VSync seems to be broken (for some people ?) Needs confirmation | Change the driver? | // | //
Unusable microphone | Microsoft added new permission blacklists in order to block illegal access to webcam/mic | // | Settings > Privacy. See if microphone access is allowed for apps. | //
Context menu doesn’t appear | Some users don't see the context menu | // | Install a new graphic cards driver | //
Fixes for Spectre and Meltdown | Spectre Variant 2 protection isn't enabled and calls InSprectre as vulnerable | // | Possible 8 May with patchday | //
Diagnostic data can't be changed | Some users see “Windows Insider Program manages this option” when they try to change the diagnostic data upload options in Settings > Privacy > Diagnostics & Feedback. | // | // | Needs to be fixed by MS
Icon and GUI glitches | See [here](https://medium.com/@itsmichaelwest/things-wrong-with-the-ui-ux-in-the-windows-10-april-2018-update-ce9c5aebbd32). | // | // | Needs to be fixed by MS
Frame drops in D3D9 games | Some games dropping frames mostly DirectX9 based ones | Enable "Disable fullscreen optimations" and "Override DPI Scaling" & Turn off/on Windows 10 game boost, and the boost setting you turn on/off on the overlay | // | Needs to be changed by Game Developers to adopt MS 'game optimization feature' 
IPv6 DNS RA and other flags are none functional | Stateless-DHCP, Router Advertisements flags are been ignored | Downgrade to Build 1703 | // | [Needs to be fixed by MS](https://social.technet.microsoft.com/Forums/windows/en-US/b16e7d78-e390-4ada-a24b-3ccba60fa571/no-ipv6-dns-statelessdhcp-since-windows-10-anniversary-update?forum=win10itpronetworking).
MAC address randomization is gone | On Home and Pro (?) versions the option is not available anymore | Install another driver | // | MS has changed this behavior, however this [feature is not as affective as you might think](https://searchsecurity.techtarget.com/tip/MAC-address-randomization-schemes-Examining-the-pros-and-cons). 
nVidia games changing the color profiles | Washed out colors with nvidia drivers | See [here](https://forums.geforce.com/default/topic/966561/finally-a-fix-for-the-games-changing-the-color-profiles-/) | New drivers ? | // 


