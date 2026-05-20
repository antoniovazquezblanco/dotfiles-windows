# Git

## Recommended Distribution

For Windows, use **Git for Windows**. It is the standard distribution, includes Git Bash, and works well with common developer workflows.

## Install via Winget

Install Git for Windows with Winget:

```powershell
winget install --id Git.Git -e --source winget
```

## Git LFS known bug

https://github.com/git-lfs/git-lfs/issues/3216

When cloning or pulling repositories with LFS over SSH from PowerShell/CMD, Git LFS can fail with errors like `Permission denied (publickey)` or missing `ssh_askpass`.

Set Git to use the Git for Windows SSH client instead of the built-in Windows OpenSSH:

```powershell
git config --global core.sshCommand "'C:\Windows\System32\OpenSSH\ssh.exe'"
```