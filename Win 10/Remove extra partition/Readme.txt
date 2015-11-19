Reboot into recovery mode. Here is a command you can launch:
C:\Windows\System32\shutdown.exe -r -o -f -t 05 -c "Restart in 5 seconds!!"

* Now go to advanced and choose 'Command Prompt'.
* In the command line type 'Diskpart'.
* Hidden partitions are not assigned a letter (that's what makes it hidden, because it has not been assigned a letter) that's why you can't delete the hidden partition by simply accessing 'Diskpart'.

You have to do in the following order: 
* 'Diskpart'
* 'list disk'
* 'select disk' (o for instance is main drive with recovery) 
* Now type 'list volume'. Now type 'select volume 1' .. ,2,3,4,5 etc.. 
* Once the desired volume is selected then type: 'ASSIGN'. This will assign a letter to that selected volume. 
* Now, select that volume again and this time type 'DELETE PARTITION OVERRIDE'.
* Then go back to disk management and look for your hidden partition. Right click on it and select the option you wish.
* Last step: Delete or create or extend volume.

NOTICE: You can extend your C drive by adding deleted partition. (Right click MY PC icon, choose MANAGE). 
Choose disk management. Right click your main C drive and choose Extend. The menu will offer to extend your volume with the 450 megs deleted

DO NOT DELETE THE ACTIVE RECOVERY PARTITION. You won't be able to add it to your C: volume. 