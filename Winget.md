# Winget

Winget (Windows Package Manager) lets you install and manage software from the command line.

## Install Winget

Run this command in PowerShell to install App Installer (which includes Winget):

```powershell
$ProgressPreference='SilentlyContinue'
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Add-AppxPackage -Path "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
```

## Verify Installation

The following command should not error out:

```powershell
winget --version
```

## Enable Winget sources

Run the following commands in PowerShell:

```powershell
winget source reset --force
winget source update
winget source list
```

You should see at least the `winget` and `msstore` sources in the output.
