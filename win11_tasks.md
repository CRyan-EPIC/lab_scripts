### Windows 11 Image Prep for Windows 11 Education

- [ ] Add GCPW
- [ ] Add ISO files and tools to the root C:\Classroom Files
    - Change the permissions to allow only admins to delete the content
    - Put a link on the Public Desktop to the C:\Classroom Files folder
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
- [ ] [RunAsTool](https://www.sordum.org/8727/runastool-v1-5/) - Download it and create links in the Public Desktop
- [ ] Install VirtualBox as an admin. Otherwise, it can't see the folders outside of the user account.
- [ ] Turn off Widgets on the taskbar. Go to gpedit.msc
    - Computer Configuration\Administrative Template\Windows Components\Widgets
- [ ] Allow non-admin users access to ncpa.cpl (changing their IP address)
    - Go to compmgmt.msc
    - SystemTools\Local Users and Groups\Groups\Network Configuration Operators
    - Add "Everyone" to it
- [ ] Programs to install [winstall website](https://winstall.app/apps)
```cmd
winget install --id=Spotify.Spotify  -e
winget install --id=PuTTY.PuTTY  -e
winget install --id=OBSProject.OBSStudio  -e
winget install --id=GIMP.GIMP  -e
winget install --id=Microsoft.WindowsTerminal  -e
winget install --id=Docker.DockerCLI  -e
winget install --id=Balena.Etcher  -e
winget install --id=JetBrains.IntelliJIDEA.Community.EAP  -e
winget install --id=KDE.Krita  -e
winget install --id=Piriform.CCleaner  -e
winget install --id=Mozilla.Firefox  -e
winget install --id=Rufus.Rufus  -e
winget install --id=7zip.7zip  -e
winget install --id=Adobe.Acrobat.Reader.64-bit  -e
winget install --id=VideoLAN.VLC  -e
winget install --id=Microsoft.VisualStudioCode  -e
winget install --id=CPUID.CPU-Z  -e
winget install --id=Git.Git  -e
winget install --id=Bitwarden.Bitwarden  -e
```

### Optional
- [ ] Enable Interactive logon: Don't display last signed-in, go to gpedit.msc
    - Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\Interactive logon
