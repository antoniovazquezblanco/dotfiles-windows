# Virtualization

There are two possible worlds here: Hyper-V (Microsoft) vs any other software (VirtualBox, VMWare...).

On one hand, Hyper-V lacks some basic virtualization features such as USB device passthrough or mounting isolated folders.

On the other hand, sometimes, it is not possible to disable Hyper-V if your PC has security requirements that depend on Windows virtualization services.

## Enabling Hyper-V

Before you proceed beware that:
- Generic USB passthrough is not possible in Hyper-V! (Only proprietary USB over IP solutions may solve this...)
- No arbitrary folder sharing support! (Only sharing full disks is possible...)

To enable Hyper-V run the following command as `Administrator`:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

Reboot your machine and you have Hyper-V Manager installed.
