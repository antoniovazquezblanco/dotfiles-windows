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
