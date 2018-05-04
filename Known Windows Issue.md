The following known issue are currently present in Windows 1803, before you submit any bug or feature request I expect that you read this document in order to get a short overview what is `broken` and what can be manually fixed or needs an Update.

- [x] [fsutil behavior set disablelastaccess 1](https://translate.google.com/translate?hl=en&sl=ja&u=http://blog.livedoor.jp/nichepcgamer/archives/1071061265.html&prev=search) Fixable via Registry/CMD
- [ ] Windows Cortana WebSearch can't be globally turned off (HKEY_LOCAL_MACHINE), the registry settings and GPO only works 'on-User Account' (HKEY_CURRENT_USER) basis.
 - [x] Chrome, Edge freezes due [broken hardware decoder](https://www.neowin.net/news/google-chrome-is-freezing-intermittently-with-the-windows-10-april-2018-update). The original issue ticket can be found [here](https://bugs.chromium.org/p/chromium/issues/detail?id=838809), [some Reddit user reporting not only Chrome is affected](https://www.reddit.com/r/Windows10/comments/8gf68w/chrome_freezes_windows_after_april_update/), see also [here](https://www.reddit.com/r/Windows10/comments/8guv3d/edge_high_cpu_usage_with_youtube/). Fixed with 17134.5+.
 - [ ] Homegroup was removed, there still GUI toggles (not working), this needs to be fixed with an GUI update.
 - [ ] Settings panel is still available as Win32 and UWP app (possible never gets fixed cause MS is too incompetent to make a UWP switch cause it would break half of the current code). 
 - [ ] GUI glitches in Windows Defender
 - [ ] Strange Unicode symbols in Registry. See [here](https://imgur.com/a/nTIc8j0).
 - [ ] Background apps re-start automatically evern after using Registry/GPO settings. Might only affect Pro (need to confirm this).
 - [x] SOund crackling, possible workaround already added. Needs confirmation if it's fixed in Realtek HD Audio Driver 6.0.1.8438 WHQL (OEM) and higher.
 - [x] Spotlight isn't working, manual fix is [here](https://www.reddit.com/r/Windows10/comments/8gxxs2/aio_fix_windows_10_any_version_spotlight_not/).
 - [x] No Simple black accent color. Fixable via registry.