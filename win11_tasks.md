### Windows 11 Image Prep for Windows 11 Education

- [ ] Add GCPW
- [ ] Add ISO files and tools to the Public Desktop
    - Useful NTFS link - https://learn.microsoft.com/en-us/answers/questions/67227/ntfs-permission
- [ ] Auto shutdown script
    - Open the Task Scheduler, click Create Task
    - General tab -- provide a name for your task
    - Triggers tab -- click New... and select the time (eg. 3:15pm)
    - Action tab -- click New... 
        - Command/Script:     shutdown
        - Arguments:          /l /f /t 0
    - Conditions tab -- uncheck Start the task only if the computer is on AC power && even when your use is not logged on.
- [ ] Turn off Cortana
    - Under gpedit.msc, User Configuration\Administrative Templates\Windows Components\Windows CoPilot\Turn off Windows CoPilot
- [ ] **OPTIONAL** Enable Interactive logon: Don't display last signed-in, go to gpedit.msc
    - Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\Interactive logon
- [ ] Add the following programs to execute without admin credentials using [Nirsoft AppCompatibiltyView tool](https://www.nirsoft.net/articles/run_application_without_elevation.html)
    - Raspi Imager, Balena Etcher, Disk part, Rufus
