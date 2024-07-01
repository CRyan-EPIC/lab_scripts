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
winget install --id=Spotify.Spotify  -e                        ::Spotify
winget install --id=YoYoGames.GameMaker.Studio.2  -e           ::GameMaker Studio 2
winget install --id=PuTTY.PuTTY  -e                            ::Putty
winget install --id=OBSProject.OBSStudio  -e                   ::OBS Studio
winget install --id=GIMP.GIMP  -e                              ::GIMP
winget install --id=Microsoft.WindowsTerminal  -e              ::Windows Terminal
winget install --id=Docker.DockerCLI  -e                       ::DockerCLI
winget install --id=Docker.DockerDesktop  -e                   ::Docker Desktop
winget install --id=Docker.DockerCompose  -e                   ::Docker Compose
winget install --id=RedHat.Podman  -e                          ::Podman
winget install --id=Balena.Etcher  -e                          ::Balena Etcher
winget install --id=JetBrains.IntelliJIDEA.Community.EAP  -e   ::IntelliJ CE
winget install --id=KDE.Krita  -e                              ::Krita
winget install --id=Piriform.CCleaner  -e                      ::CCleaner
winget install --id=Mozilla.Firefox  -e                        ::Firefox
winget install --id=Rufus.Rufus  -e                            ::Rufus
winget install --id=7zip.7zip  -e                              ::7zip
winget install --id=Adobe.Acrobat.Reader.64-bit  -e            ::Adobe PDF Reader
winget install --id=VideoLAN.VLC  -e                           ::VLC
winget install --id=Microsoft.VisualStudioCode  -e             ::VSCode
winget install --id=CPUID.CPU-Z  -e                            ::CPUID
winget install --id=Git.Git  -e                                ::Git
winget install --id=Bitwarden.Bitwarden  -e                    ::Bitwarden
winget install --id=PrimateLabs.Geekbench.6  -e                ::Geekbench
winget install --id=Oracle.VirtualBox  -e                      ::VirtualBox
```

### Optional
- [ ] Enable Interactive logon: Don't display last signed-in, go to gpedit.msc
    - Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\Interactive logon
