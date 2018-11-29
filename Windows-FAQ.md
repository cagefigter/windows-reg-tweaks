#### How do I more from an Intel CPU+Mobo to AMD CPU+Mobo (or vice versa) without reinstalling Windows?

Start > Run > sysprep. Select "OOBE", tick "Generalize" (sysprep /generalize), and select "Shutdown". Then replace your motherboard. The next time Windows boots, it should act like it's the first time boot, and setup all your drivers from scratch. Keep in mind that Windows might wipe all external drivers, so you need the new ones + maybe others like graphics drivers. You also have to re-activate Windows except if you [link the key to your MS Account](https://www.windowscentral.com/how-link-your-windows-10-product-key-microsoft-account).

The alternative is to use [Macrium Reflect](https://www.macrium.com/reflectfree).


#### Can I use the MAK key to activate a Retail version?

Yup.


#### Should I Upgrade to Windows 10?

Those who aren’t concerned about if they have to upgrade are usually wondering if they should upgrade. So should you upgrade to Windows 10? Barring some compelling reason for not doing so (like you can’t get drivers for a piece of hardware your job depends on) there’s very little reason to not upgrade to Windows 10.

#### Do Windows 8.1 drivers work with Windows 10?

Most Windows 8.1 drivers should work fine with Windows 10, but depending what the driver is for, it may require a Windows 10 driver to function properly.


#### How long does it take to upgrade?

In most cases it takes maximum an hour, but it's depending on how old your PC is. For me it takes 10 minutes on a SSD and 9 with an M.2.


#### What are the differences between the different Windows 10 versions?

You can find a feature comparison from Microsoft [right here](http://www.microsoft.com/en-us/windows/windows-10-editions).


#### My computer seems really slow just after upgrading

Immediately after upgrading to Windows 10, the OS completes a number of tasks and optimizations. This may slow the system down for a period of time. Try waiting for an hour and rebooting the computer to see if the speed improves.


#### Will I lose my files by upgrading to Windows 10?

No, your Windows settings, personal files and most apps will remain. However it is highly recommended to backup important files before upgrading, just in case.


#### Where can I find drivers for Windows 10?

If Windows Update did not provide you with the necessary drivers, you should check the manufacturer's website. Even if your PC manufacturer does not have any Windows 10 drivers available, the individual component manufacturer's website may have one listed. Personally I use WSUS, Win-raid forum and Station-Drivers. 


#### Can I Downgrade Back To Windows 7 or 8 If I Hate Windows 10?

You can absolutely downgrade from Windows 10 back to the previous version of Windows 7 or Windows 8.1. You can even totally wipe your machine and reinstall your old version of Windows with the old key. But, and this is a very big but, you can only do so within the first 30 days.


#### Will My Old Apps And Peripherals Still Work?

I haven’t run into a single app that hasn’t worked yet. It's more a driver thing. UWP apps however are Windows 8+ exclusive.


#### How often does the LTSC update Windows 10 LTSB?

Windows 10 LTSB does receive the usual monthly security updates. The twice-annual feature upgrades delivered to other channels will not be offered to LTSB systems. Microsoft upgrades the LTSB "build" every two to three years. Those upgrades, however, are optional, or at least optional to some degree (more on that later). Each LTSB build is supported with security updates for a decade, the same 10-year lifespan Microsoft has designated and maintained for ages. The decade is split into two equal halves: "Mainstream" support for the first five years, "Extended" for the second. For Windows 10 Enterprise 2016 LTSB, Mainstream support ends in October 2021 and Extended stops in October 2026.


#### Does Windows 10 Report Back To Microsoft?

Windows has, for ages, reported back to Microsoft in various forms. The most obvious and enduring reporting is the basic Windows authentication process. There’s also the equally as old error reporting service that phones home when your programs crash and things fall apart so Microsoft can, ostensibly, prevent such problems in the future.


#### What is Windows 10 LTSB (now LTSC)?

LTSB is a specialized edition (for ATM's etc) of Windows 10 Enterprise that promises the longest intervals between feature upgrades of any version of the operating system. When Microsoft dropped multiple labels for Windows 10's release tracks, those now retired included "Current Branch" and the unwieldy "Current Branch for Business", for the single "Semi-Annual Channel" (SAC) it also debuted "Long-term Servicing Channel" (LTSC) to match.


#### LTSB/LTSC - what is missing?

LTSB does not include Edge nor any Microsoft Store (Universal Windows Platform aka UWP) apps, whether Redmond made or third-part, because the browser and those apps constantly change and need updating. The Cortana voice-activated digital assistant and access to the Microsoft Store is also missing.


#### Can I defer security updates if we're on LTSB?

Servicing tools such as Windows Server Update Services (WSUS) and System Center Configuration Manager (SCCM) let administrators delay the monthly security updates, which Microsoft calls "quality updates", just as they can postpone those same patches reaching machines running other versions of Window 10.


#### How long is LTSB supported?

Ten years is usually the answer you see to that one. But it would be, if not wrong, then misleading. Windows 10 Enterprise LTSB is guaranteed only five years of support - from the time of its release, not its installation - if the underlying license does not have SA attached. With SA, a specific LTSB edition is supported for the full 10 years.


#### Can I transfer my OEM license?

A OEM license is non transferable between motherboards. If you have a retail license you may or may not need to reactivate windows after the switch. And you may or may not need to call microsoft to do it.


#### How to use DISM command-line utility to repair a Windows 10 image?

I think [this guide here](https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image?utm_medium=slider&utm_campaign=navigation&utm_source=wp) explains it well.



## Official Links
- [Upgrade to Windows 10: FAQ](https://support.microsoft.com/en-us/help/12435/windows-10-upgrade-faq#iconz-faq)
