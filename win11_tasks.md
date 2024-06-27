### Windows 11 Image Prep

- [ ] Add ISO files and tools to the Public Desktop
    - Useful NTFS link - https://learn.microsoft.com/en-us/answers/questions/67227/ntfs-permission
- [ ] Auto shutdown script
```cmd
C:\Windows\System32\shutdown.exe /l /f /t 0
```
- [ ] Turn off Cortana
    - Click Start and search for "gpedit" to open the Group Policy Editor.
    - Navigate to User Configuration > Administrative Templates > Windows Components > Windows CoPilot.
    - Double-click Turn off Windows CoPilot.
    - Click Enabled, then Apply, and OK.
- [ ] Disable Last Person Logon Memory
- [ ] Add the following programs
