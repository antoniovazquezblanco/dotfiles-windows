# PowerShell Notes

Minimal notes for PowerShell setup used in this Windows dotfiles repo.

## PowerShellGet

PowerShellGet is a module manager used to find, install, and update PowerShell modules from repositories like PSGallery.

To update PowerShellGet run the following as `Administrator`:

```powershell
Install-Module -Name PowerShellGet -Force
```

Close the terminal and reopen it before proceeding!

## PSReadLine

PSReadLine improves the PowerShell command-line editing experience with syntax highlighting, better history search, and key bindings.

These instructions require you to install [PowerShellGet](#powershellget) first.

Install PSReadLine as `Administrator`:

```powershell
Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -Force
```

## posh-sshell

PowerShell module that provides utilities for working with SSH connections within PowerShell. Among others, it can automatically start the SSH Agent for you.

Install Posh SSHell as `Administrator`:

```powershell
Install-Module posh-sshell -Repository PSGallery -Scope CurrentUser -Force
Add-PoshSshellToProfile
```

Configure SSH agent startup, also as `Administrator`:
```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service -Name ssh-agent
if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }; if (-not (Select-String -Path $PROFILE -Pattern 'Start-SshAgent -Quiet' -SimpleMatch -Quiet)) { Add-Content -Path $PROFILE -Value 'Start-SshAgent -Quiet' }
```