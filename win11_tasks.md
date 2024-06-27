### Windows 11 Image Prep

- [ ] Add ISO files and tools to the Public Desktop
    - Useful NTFS link - https://learn.microsoft.com/en-us/answers/questions/67227/ntfs-permission
- [ ] Auto shutdown script
```cmd
C:\Windows\System32\shutdown.exe /l /f /t 0
```
- [ ] Turn off Cortana
    - Under gpedit.msc, User Configuration\Administrative Templates\Windows Components\Windows CoPilot\Turn off Windows CoPilot
- [ ] Enable Interactive logon: Don't display last signed-in, go to gpedit.msc
    - Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\Interactive logon
- [ ] Add the following programs
